#!/usr/bin/env bash
#
# bootstrap-github-oidc.sh
#
# Idempotently (re)creates the AWS-side trust that lets GitHub Actions
# deploy to this AWS Academy account via short-lived OIDC tokens.
# Safe to re-run after every AWS Academy lab reset -- no long-lived
# AWS access keys are ever created, stored, or copy-pasted anywhere.
#
# Prerequisites:
#   - Run this FROM an EC2 instance with LabInstanceProfile attached
#     (or Cloud9), so the AWS CLI already has temporary credentials
#     via the instance metadata service. No aws configure needed.
#   - GitHub CLI installed and authenticated: gh auth login
#
# Usage:
#   ./bootstrap-github-oidc.sh <github-owner>/<repo>           # create/refresh
#   ./bootstrap-github-oidc.sh <github-owner>/<repo> --destroy # tear down the role

set -euo pipefail

REPO="${1:?Usage: $0 <github-owner>/<repo> [--destroy]}"
MODE="${2:-}"
REGION="${AWS_REGION:-us-east-1}"
ROLE_NAME="gha-deploy-$(basename "$REPO")"
OIDC_HOST="token.actions.githubusercontent.com"
THUMBPRINT="6938fd4d98bab03faadb97b34396831e3780aea1"
POLICY_ARN="arn:aws:iam::aws:policy/PowerUserAccess"

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
PROVIDER_ARN="arn:aws:iam::${ACCOUNT_ID}:oidc-provider/${OIDC_HOST}"

if [[ "$MODE" == "--destroy" ]]; then
  echo "Tearing down role for $REPO ..."
  aws iam detach-role-policy --role-name "$ROLE_NAME" --policy-arn "$POLICY_ARN" 2>/dev/null || true
  aws iam delete-role --role-name "$ROLE_NAME" 2>/dev/null || true
  # The OIDC provider is left in place on purpose: other repos/roles may
  # still depend on it. Delete it manually with `aws iam delete-open-id-connect-provider`
  # only if you are sure no other role trusts it.
  echo "Role $ROLE_NAME removed. OIDC provider left untouched (shared resource)."
  exit 0
fi

echo "Account: $ACCOUNT_ID | Repo: $REPO | Role: $ROLE_NAME"

# 1. OIDC provider -- create only if it doesn't already exist
if aws iam get-open-id-connect-provider --open-id-connect-provider-arn "$PROVIDER_ARN" >/dev/null 2>&1; then
  echo "OIDC provider already exists, skipping."
else
  echo "Creating OIDC provider..."
  aws iam create-open-id-connect-provider \
    --url "https://${OIDC_HOST}" \
    --client-id-list sts.amazonaws.com \
    --thumbprint-list "$THUMBPRINT"
fi

# 2. Trust policy -- only THIS repo's OIDC tokens may assume the role
TRUST_POLICY=$(cat <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Principal": {"Federated": "${PROVIDER_ARN}"},
    "Action": "sts:AssumeRoleWithWebIdentity",
    "Condition": {
      "StringEquals": {"${OIDC_HOST}:aud": "sts.amazonaws.com"},
      "StringLike": {"${OIDC_HOST}:sub": "repo:${REPO}:*"}
    }
  }]
}
EOF
)

# 3. Role -- create it, or just refresh the trust policy if it survived a reset
if aws iam get-role --role-name "$ROLE_NAME" >/dev/null 2>&1; then
  echo "Role already exists, refreshing trust policy..."
  aws iam update-assume-role-policy --role-name "$ROLE_NAME" \
    --policy-document "$TRUST_POLICY"
else
  echo "Creating role..."
  aws iam create-role --role-name "$ROLE_NAME" \
    --assume-role-policy-document "$TRUST_POLICY"
fi

# 4. Permissions -- re-attaching an already-attached policy is a safe no-op
aws iam attach-role-policy --role-name "$ROLE_NAME" --policy-arn "$POLICY_ARN"

ROLE_ARN=$(aws iam get-role --role-name "$ROLE_NAME" --query 'Role.Arn' --output text)
echo "Role ARN: $ROLE_ARN"

# 5. Publish to GitHub as a plain repo VARIABLE -- never a secret, never a
#    plaintext key. The ARN by itself is useless to anyone who doesn't also
#    control this exact repo's OIDC tokens.
gh variable set AWS_ROLE_ARN --repo "$REPO" --body "$ROLE_ARN"
gh variable set AWS_REGION   --repo "$REPO" --body "$REGION"

echo "Done. GitHub Actions in $REPO can now deploy via OIDC -- no AWS keys stored anywhere."
