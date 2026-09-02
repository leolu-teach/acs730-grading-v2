#!/usr/bin/env bash
set -euo pipefail

GROUP_ID=$(aws ec2 create-security-group \
  --group-name acs730-lab1-sg \
  --description "ACS730 lab1 test security group" \
  --query 'GroupId' --output text)

aws ec2 authorize-security-group-ingress \
  --group-id "$GROUP_ID" \
  --protocol tcp --port 22 --cidr 0.0.0.0/0

echo "Security group created: $GROUP_ID"
