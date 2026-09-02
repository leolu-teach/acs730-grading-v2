#!/usr/bin/env bash
#
# run-tests.sh
#
# Deterministic, no-AI test runner. Scans the deliverable folders in the
# current checkout and runs whatever lightweight, offline-safe checks apply
# based on what file types it finds -- Terraform validate, Docker build,
# Ansible syntax check, Kubernetes manifest dry-run, tfsec scan, plus basic
# git-hygiene checks. Writes a single markdown results file.
#
# This script does NOT judge quality or award a grade -- it only reports
# PASS/FAIL/SKIP per mechanical check. A human (or a Claude Code session,
# per the instructor's workflow) reads these results, plus the actual code,
# to produce the real grade.

set -uo pipefail

BRANCH="${1:?Usage: $0 <branch-name> <output-file> [scan-dir]}"
OUT="${2:?Usage: $0 <branch-name> <output-file> [scan-dir]}"
SCAN_DIR="${3:-.}"
mkdir -p "$(dirname "$OUT")"
OUT="$(cd "$(dirname "$OUT")" && pwd)/$(basename "$OUT")"  # absolute, so it survives the cd below
cd "$SCAN_DIR"

DELIVERABLE_DIRS="lab1 lab2 lab3 lab4 lab5 lab6 lab7 lab8 assignment1 assignment2 midterm-practice final-practice final-project"

{
  echo "# Test Results: $BRANCH"
  echo
  echo "_Generated $(date -u +%Y-%m-%dT%H:%M:%SZ) by run-tests.sh. This is a mechanical PASS/FAIL report, not a grade._"
  echo
} > "$OUT"

run_check() {
  local label="$1"; shift
  local logfile
  logfile="$(mktemp)"
  if "$@" > "$logfile" 2>&1; then
    echo "- ✅ **PASS** -- $label" >> "$OUT"
  else
    echo "- ❌ **FAIL** -- $label" >> "$OUT"
    echo '  <details><summary>output</summary>' >> "$OUT"
    echo '' >> "$OUT"
    echo '  ```' >> "$OUT"
    sed 's/^/  /' "$logfile" | tail -40 >> "$OUT"
    echo '  ```' >> "$OUT"
    echo '  </details>' >> "$OUT"
  fi
  rm -f "$logfile"
}

# Informational-only variant (e.g. tfsec): always shown as ℹ️, never PASS/FAIL.
# Whether an open port or a given finding is a real problem depends on which
# week/lab this is (e.g. a public web server intentionally opens port 80) --
# that judgment call belongs to whoever grades this, not to this script.
run_info() {
  local label="$1"; shift
  local logfile
  logfile="$(mktemp)"
  "$@" > "$logfile" 2>&1
  local rc=$?
  echo "- ℹ️ **FINDINGS** ($label, exit $rc -- review, does not auto-fail)" >> "$OUT"
  echo '  <details><summary>output</summary>' >> "$OUT"
  echo '' >> "$OUT"
  echo '  ```' >> "$OUT"
  sed 's/^/  /' "$logfile" | tail -60 >> "$OUT"
  echo '  ```' >> "$OUT"
  echo '  </details>' >> "$OUT"
  rm -f "$logfile"
}

for dir in $DELIVERABLE_DIRS; do
  [ -d "$dir" ] || continue

  has_content=$(find "$dir" -type f ! -name '.gitkeep' ! -iname 'README.md' | head -1)
  if [ -z "$has_content" ]; then
    echo "## $dir" >> "$OUT"
    echo "- ⚪ **EMPTY** -- no submitted files found" >> "$OUT"
    echo >> "$OUT"
    continue
  fi

  echo "## $dir" >> "$OUT"
  matched_anything=0

  # --- Shell scripts: cheap syntax-only sanity check, applies broadly ---
  sh_files=$(find "$dir" -iname '*.sh' 2>/dev/null)
  for sf in $sh_files; do
    matched_anything=1
    run_check "bash -n syntax check ($sf)" bash -n "$sf"
  done

  # --- Terraform ---
  tf_dirs=$(find "$dir" -name '*.tf' -exec dirname {} \; 2>/dev/null | sort -u)
  for tfd in $tf_dirs; do
    matched_anything=1
    run_check "terraform validate ($tfd)" bash -c "cd '$tfd' && terraform init -backend=false -input=false && terraform validate"
    if command -v tfsec >/dev/null 2>&1; then
      if [ "$dir" = "lab7" ]; then
        # lab7 = Week 12, Security & Policy-as-Code: this is the one folder
        # where "tfsec finds nothing HIGH/CRITICAL" is the actual point of
        # the exercise, so it's a real pass/fail gate here, not just FYI.
        run_check "tfsec scan ($tfd), no HIGH/CRITICAL findings (required for this lab)" bash -c "tfsec '$tfd' --minimum-severity HIGH"
      else
        run_info "tfsec scan ($tfd)" tfsec "$tfd"
      fi
    fi
  done

  # --- Docker ---
  dockerfiles=$(find "$dir" -iname 'Dockerfile' 2>/dev/null)
  for df in $dockerfiles; do
    matched_anything=1
    ddir=$(dirname "$df")
    run_check "docker build ($df)" docker build -q -f "$df" "$ddir"
  done

  # --- Ansible ---
  ansible_dirs=$(find "$dir" -type d -iname 'ansible' 2>/dev/null)
  for ad in $ansible_dirs; do
    playbooks=$(find "$ad" -maxdepth 2 -iname '*.yml' -o -iname '*.yaml' 2>/dev/null)
    for pb in $playbooks; do
      matched_anything=1
      run_check "ansible-playbook --syntax-check ($pb)" ansible-playbook --syntax-check "$pb"
    done
  done

  # --- Kubernetes manifests (client-side only, no live cluster needed) ---
  k8s_dirs=$(find "$dir" -type d -iname 'k8s' 2>/dev/null)
  for kd in $k8s_dirs; do
    manifests=$(find "$kd" -iname '*.yaml' -o -iname '*.yml' 2>/dev/null)
    for m in $manifests; do
      matched_anything=1
      run_check "kubectl apply --dry-run=client ($m)" kubectl apply --dry-run=client -f "$m"
    done
  done

  # --- Packer ---
  packer_files=$(find "$dir" -iname '*.pkr.hcl' 2>/dev/null)
  for pf in $packer_files; do
    matched_anything=1
    run_check "packer validate ($pf)" packer validate "$pf"
  done

  if [ "$matched_anything" -eq 0 ]; then
    file_list=$(find "$dir" -type f ! -iname 'README.md' | sed 's/^/    - /')
    echo "- 📄 **FILES PRESENT, NO AUTOMATED CHECK FOR THIS CONTENT TYPE** -- needs manual/Claude-session review:" >> "$OUT"
    echo "$file_list" >> "$OUT"
  fi

  echo >> "$OUT"
done

# --- Repo-wide git hygiene (runs once, not per folder) ---
echo "## Repository-wide hygiene" >> "$OUT"
if git log --all --name-only --pretty=format: 2>/dev/null | grep -E '\.(tfstate|pem)$|(^|/)credentials$' | grep -q .; then
  echo "- ❌ **FAIL** -- found a \`.tfstate\`, \`.pem\`, or \`credentials\` file somewhere in git history" >> "$OUT"
else
  echo "- ✅ **PASS** -- no \`.tfstate\`/\`.pem\`/\`credentials\` files found anywhere in git history" >> "$OUT"
fi

echo "Wrote $OUT"
