# Stage 2 Grading Report: test-student-partial

_Produced by reading `grading/results/submissions-test-student-partial.md` (Stage 1 mechanical output) plus the actual submitted code on branch `submissions/test-student-partial`, against the rubric(s) in `grading/rubrics/`. This is the human/Claude-judgment step -- nothing here was computed by the pipeline itself._

## lab1 -- 6.5 / 10

Rubric: `grading/rubrics/lab1.md`

| Item | Points | Awarded | Notes |
|---|---|---|---|
| `.gitignore` present and committed before any other files | 2 | 1.5 | `.gitignore` exists and correctly excludes `*.pem`, `*.tfstate`, `.terraform/`, `credentials`, etc. However the whole submission landed in a single flat commit (`a4d568e`), so "committed before any other files" can't be verified from history -- docking 0.5 rather than the full ordering requirement. |
| AWS CLI wrapper script(s) exist and executable | 2 | 2 | Both `create-instance.sh` and `create-security-group.sh` present, `chmod +x` (mode 100755), content matches the Week 1 spec (t3.micro, current AL2023 AMI, `LabInstanceProfile`; SG opens only port 22). |
| Commit history shows a merged PR via a feature branch | 3 | 0 | No feature branch, no PR -- one direct commit to `main`. This is the biggest gap: the actual Git/GitHub workflow (branch -> PR -> merge) that Lab 1 is meant to teach was skipped even though the deliverable files are correct. |
| No `.pem`/`.tfstate`/`credentials` in history | 2 | 2 | Confirmed by Stage 1 pipeline's repo-wide hygiene check: ✅ PASS. |
| README explains what the scripts do | 1 | 1 | Present, accurate, concise. |

**Lab 1 is functionally complete but process-incomplete** -- the artifacts are right, the Git workflow that's the actual point of the lab isn't demonstrated.

## lab2 -- 3 / 10 (estimated; no formal rubric file exists yet for lab2)

Stage 1: `bash -n` syntax check on `deploy-web.sh` -- ✅ PASS.

Inferred rubric, matching lab1's style and the Week 2 (Linux Admin & EC2 Deploy) lab intent:

| Item | Points | Awarded | Notes |
|---|---|---|---|
| Deploy script installs/configures/starts the web server correctly | 4 | 3 | `dnf install httpd`, writes `index.html`, `systemctl start httpd`, curls it to confirm -- correct sequence, but never `systemctl enable`, so the service would not survive a reboot. |
| Service persistence (enabled, not just started) | 2 | 0 | Not done. |
| Evidence the deployment was actually tested (output/screenshot) | 2 | 0 | Nothing committed. |
| README documenting the lab | 2 | 0 | Missing entirely. |

**Lab 2 is a real, working start but clearly unfinished** -- matches the "in progress" framing of the submission.

## lab3 -- 5 / 10 (estimated; no formal rubric file exists yet for lab3)

Stage 1: `terraform validate` -- ❌ **FAIL** (`Reference to undeclared input variable "var.instance_type"`, main.tf line 32). tfsec -- ℹ️ informational only (ingress `0.0.0.0/0` on port 22 flagged, not gating for this lab).

| Item | Points | Awarded | Notes |
|---|---|---|---|
| `terraform validate` passes (baseline requirement) | 3 | 0 | Fails outright -- this blocks `plan`/`apply` entirely, so nothing in this config can actually be deployed. |
| Security group resource correct | 4 | 4 | `aws_security_group.lab3_demo` is well-formed and matches the lab's intent (SSH-only ingress). |
| EC2 instance resource | 3 | 1 | Present and structurally reasonable (right `ami`/`instance_type` fields used) but references a variable (`var.instance_type`) that's never declared -- an easy, common mistake, but it's exactly the kind of thing the validate step exists to catch. Partial credit for the attempt, not for a working config. |

**Lab 3 has a real, specific bug** that a student would need one `variable "instance_type" {}` block (or a hardcoded value) to fix -- good test case for "the pipeline catches a genuine mistake without being fooled by an AI-generated-looking fix."

## assignment1 -- 4 / 100

Rubric: `course-redesign/assessments/Assignment1.md` grade breakdown.

| Task | Points | Awarded | Notes |
|---|---|---|---|
| Introduction | 5 | 2 | `REPORT.md` has an Introduction section, but it's one sentence stating what's *not* done rather than describing the assignment's objectives in the student's own words. |
| 1. Reusable module | 10 | 0 | No `terraform/modules/` directory. |
| 2. dev/staging/prod directories | 10 | 2 | Only `terraform/dev/` exists, and it doesn't call a module (there isn't one) -- it's a single hardcoded `aws_security_group`. `staging/` and `prod/` don't exist. Partial credit for a valid, if minimal, dev config. |
| 3. GitHub Environments configuration | 10 | 0 | No `evidence/environments.png`, not configured. |
| 4. Scoped OIDC trust policy | 10 | 0 | Not in `REPORT.md`. |
| 5. Real deployment (staging + prod) | 20 | 0 | No evidence screenshots, nothing deployed. |
| 6. Secrets management | 10 | 0 | No `data` source / SSM parameter. |
| 7. CloudWatch alarm | 10 | 0 | Not present. |
| 8. Recommendation write-up | 10 | 0 | Not written. |
| Conclusion | 5 | 0 | Not written. |

**Assignment 1 is at the very start** -- one Terraform resource and a stub report, consistent with the submission's stated intent ("work in progress"). Stage 1 correctly showed this folder as passing its one mechanical check (`terraform validate` ✅, tfsec ℹ️ informational -- the intentional port-80-open pattern is correctly *not* flagged as a failure here) while Stage 2 correctly shows that passing `terraform validate` on one resource is nowhere near assignment-complete.

## Untouched (still template placeholders)

lab4, lab5, lab6, lab7, lab8, assignment2, midterm-practice, final-practice, final-project -- Stage 1 correctly reported all of these as ⚪ **EMPTY**. No Stage 2 grade applicable (0 / full value each, or excluded if not yet due).

## Running subtotal (labs + assignment1 only, out of what's gradable so far)

| Item | Score |
|---|---|
| Lab 1 | 6.5 / 10 |
| Lab 2 | 3 / 10 |
| Lab 3 | 5 / 10 |
| Assignment 1 | 4 / 100 |

## Conclusion: does this validate the workflow?

Yes. This run demonstrates the two-stage design working exactly as intended for a **partial, mixed-quality submission**, not just the all-empty or all-complete extremes:

- Stage 1 (mechanical, no AI, in Actions) correctly told the difference between *complete* (lab1: both scripts pass syntax check), *broken* (lab3: validate genuinely fails on a real bug), *present-but-uncheckable-by-a-fixed-rule-set* (assignment1's REPORT.md content, lab2's missing pieces), and *not started* (lab4-8, etc.) -- without ever calling an LLM.
- Stage 2 (this document, done by reading Stage 1's output + the actual code + the rubric) is where the actual judgment happens: crediting a script that works even though its systemd unit is missing, penalizing a Git workflow that skipped the branch/PR step despite correct file contents, and mapping partial assignment progress onto the real 100-point breakdown from `Assignment1.md`.
- No case produced a false PASS (nothing incomplete was scored as done) or a false FAIL (the intentional port-80 pattern in assignment1 was not penalized).

Open item: `grading/rubrics/` only has `lab1.md`. lab2-8, assignment2, and final-project rubric files should be written before real student grading begins, so Stage 2 has a fixed point breakdown to work from instead of an estimate each time.
