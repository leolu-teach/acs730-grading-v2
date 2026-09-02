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

---

## Round 2 (2026-09-02): lab4, lab6, lab7, lab8, assignment2, final-project

Added submissions for the remaining labs, assignment2, and final-project specifically to exercise
the check types round 1 never touched: `docker build`, `ansible-playbook --syntax-check`,
`packer validate`, the lab7 tfsec hard-gate, and Kubernetes manifests. This run found and fixed two
more real pipeline bugs before producing any of the grades below (see "Bugs found" at the end).

### lab4 -- 9 / 10 (estimated; no formal rubric file yet)

Stage 1: `docker build` -- ✅ PASS.

Dockerfile, `app.py`, `requirements.txt`, `.dockerignore`, and README are all present and correct --
a small Flask app, slim base image, proper layer ordering, sensible `.dockerignore`. Docking 1 point
only because the container still runs as root (a named "Container Security Basics" objective for
this week) -- everything else matches the Week 4 lab spec cleanly.

### lab6 -- 6 / 10 (estimated; no formal rubric file yet)

Stage 1: `ansible-playbook --syntax-check` -- ✅ PASS. `packer validate` -- ❌ **FAIL**
(`This object does not have an attribute named "instance_type"` -- a real bug: `var.instance_type`
is referenced but never declared, the same class of mistake as lab3).

The Ansible half (playbook + template + inventory) is complete and correctly structured. The Packer
half is attempted but doesn't validate, so the "build one golden AMI and compare boot time" half of
the lab has nothing to compare against yet. Roughly half credit.

### lab7 -- 4 / 10 (estimated; no formal rubric file yet)

Stage 1: `terraform validate` -- ✅ PASS. tfsec (required gate for this lab) -- ❌ **FAIL**
(1 CRITICAL + 5 HIGH findings on an S3 bucket with encryption/public-access-block disabled).

This is graded generously as "step 1 of 2, correctly done": the lab explicitly asks students to
*first* reproduce a real misconfiguration so the required check has something genuine to catch, then
fix it. The FAIL here is expected and correct at this stage -- the submission's own README says as
much ("confirmed the pipeline blocks this... TODO: fix the bucket"). Credit given for a working,
gate-triggering reproduction; no credit yet for the fix, which is the point of the lab and isn't
done.

### lab8 -- 7 / 10 (estimated; no formal rubric file yet)

Stage 1: `kubeconform` -- `deployment.yaml` ✅ PASS, `service.yaml` ✅ PASS, `hpa.yaml` ❌ **FAIL**
(`could not find schema for HorizontalPodAutoscaler` -- real bug: `apiVersion: apps/v1` is wrong,
`HorizontalPodAutoscaler` lives in `autoscaling/v1` or `autoscaling/v2`).

Core lab objective (deploy + expose via a Service) is done correctly. The scaling extension
(`kubectl get pods` while scaling) is attempted but the manifest has a real, specific
apiVersion/kind mismatch that would need to be fixed before it could even be applied.

### assignment2 -- 18 / 100

Rubric: `course-redesign/assessments/Assignment2.md` grade breakdown.

Stage 1: `ansible-playbook --syntax-check (assignment2/ansible/playbook.yml)` -- ✅ PASS.
`YAML syntax check (inventory: assignment2/ansible/inventory/aws_ec2.yml)` -- ✅ PASS (this is the
dynamic-inventory plugin config the task actually asks for -- see the bug note below on why this
needed its own check type rather than being run through `ansible-playbook --syntax-check`).

| Task | Points | Awarded | Notes |
|---|---|---|---|
| Introduction | 5 | 2 | Present, but states what's not done rather than the assignment's objectives. |
| 1. Dynamic inventory | 10 | 6 | `ansible/inventory/aws_ec2.yml` correctly uses the `amazon.aws.aws_ec2` plugin with `filters`/`keyed_groups`; missing `evidence/inventory-graph.txt`. |
| 2. Ansible role structure | 15 | 10 | Proper `roles/webserver/{tasks,defaults,templates}` layout, referenced from a top-level `playbook.yml`; REPORT.md doesn't yet explain the structure. |
| 3. Idempotency proof | 15 | 0 | No evidence files. |
| 4. Pipeline integration | 15 | 0 | No workflow step, no evidence. |
| 5. Golden AMI (Packer) | 15 | 0 | Not present. |
| 6. Boot-time comparison | 10 | 0 | Not written. |
| 7. Comparison write-up | 10 | 0 | Not written. |
| Conclusion | 5 | 0 | Not written. |

### final-project -- 16 / 100

Rubric: `course-redesign/assessments/FinalProject.md` grade breakdown.

Stage 1: `terraform validate` ✅ PASS, tfsec ℹ️ informational (correctly not gating -- only lab7 is a
hard gate), `ansible-playbook --syntax-check` ✅ PASS, both `k8s/*.yaml` ✅ PASS via kubeconform.

| Section | Points | Awarded | Notes |
|---|---|---|---|
| Terraform provisioning (module + multi-env) | 15 | 3 | One `terraform/dev/` security group, no module, no staging/prod -- same early state as assignment1. |
| Configuration management (Ansible and/or Packer) | 15 | 6 | Valid playbook for the VM-based piece; no evidence it's been applied, no golden-AMI alternative. |
| Kubernetes deployment via the CI/CD pipeline | 15 | 4 | Manifests are valid and would deploy the frontend, but there's no pipeline (`.github/workflows/final-project-deploy.yml`) actually doing it yet -- "via the pipeline" is the part that's missing. |
| Automatic deploy on merge, zero stored credentials | 10 | 0 | No workflow file at all yet. |
| Monitoring signal | 10 | 0 | Not present. |
| Required security scan blocking on findings | 10 | 0 | Not configured (this is a student-owned required-check setting, not something `run-tests.sh` grants automatically). |
| REPORT.md | 15 | 3 | Architecture overview only; design decision, retrospective, and "what I'd change" are all missing. |
| Live demo | 10 | 0 | N/A at this stage. |

### Bugs found and fixed this round (before any of the grades above were produced)

1. **`kubectl apply --dry-run=client` needs a live API server for REST-mapping discovery**, which a
   bare `ubuntu-latest` runner doesn't have -- every Kubernetes manifest, no matter how correct,
   would have failed with `connection refused`, a false failure on 100% of submissions. Replaced
   with `kubeconform` (a static OpenAPI schema validator, genuinely offline), confirmed both that it
   passes correct manifests and that it does flag a real error (the `hpa.yaml` apiVersion/kind
   mismatch above) rather than silently skipping unknown kinds.
2. **A dynamic-inventory YAML file (e.g. `amazon.aws.aws_ec2` plugin config) inside an `ansible/`
   folder was being run through `ansible-playbook --syntax-check` as if it were a playbook**, which
   would always fail (it's a single config dict, not a list of plays) -- a guaranteed false failure
   for exactly the kind of file Assignment 2 requires. Fixed by excluding `*/inventory/*` from the
   playbook check and instead doing a plain YAML-syntax check on inventory files (no AWS API calls,
   stays offline-safe).
3. Also added: `packer init` before `packer validate` (so the required-plugin declaration doesn't
   block validation from ever reaching the actual template content), and installed `packer` and
   `kubeconform` on the runner (neither had been installed before -- `packer validate` and
   `kubectl` would have failed on every submission that used them, for reasons unrelated to the
   student's actual work).

## Untouched (still empty by design)

lab5, midterm-practice, final-practice -- Stage 1 correctly reported all of these as ⚪ **EMPTY**.
(lab5 is intentionally left as a template placeholder for this test; midterm-practice/final-practice
stay empty until their exam windows open.)

## Running subtotal (out of what's gradable so far)

| Item | Score |
|---|---|
| Lab 1 | 6.5 / 10 |
| Lab 2 | 3 / 10 |
| Lab 3 | 5 / 10 |
| Lab 4 | 9 / 10 |
| Lab 6 | 6 / 10 |
| Lab 7 | 4 / 10 |
| Lab 8 | 7 / 10 |
| Assignment 1 | 4 / 100 |
| Assignment 2 | 18 / 100 |
| Final Project | 16 / 100 |

## Conclusion: does this validate the workflow?

Yes. This run demonstrates the two-stage design working exactly as intended for a **partial, mixed-quality submission**, not just the all-empty or all-complete extremes:

- Stage 1 (mechanical, no AI, in Actions) correctly told the difference between *complete* (lab1: both scripts pass syntax check), *broken* (lab3: validate genuinely fails on a real bug), *present-but-uncheckable-by-a-fixed-rule-set* (assignment1's REPORT.md content, lab2's missing pieces), and *not started* (lab4-8, etc.) -- without ever calling an LLM.
- Stage 2 (this document, done by reading Stage 1's output + the actual code + the rubric) is where the actual judgment happens: crediting a script that works even though its systemd unit is missing, penalizing a Git workflow that skipped the branch/PR step despite correct file contents, and mapping partial assignment progress onto the real 100-point breakdown from `Assignment1.md`.
- No case produced a false PASS (nothing incomplete was scored as done) or a false FAIL (the intentional port-80 pattern in assignment1 was not penalized).

Round 2 extended coverage to every remaining check type -- `docker build`, `ansible-playbook
--syntax-check`, dynamic-inventory YAML, `packer validate`, the lab7 tfsec hard gate, and Kubernetes
manifests -- and, importantly, it's the round that actually caught real pipeline defects rather than
just confirming the design: `kubectl apply --dry-run=client` would have false-failed literally every
Kubernetes submission (no live cluster on the runner), a dynamic-inventory YAML file would have
false-failed every correctly-done Assignment 2 (treated as a malformed playbook), and `packer`
wasn't even installed. All three are fixed and re-verified in this same run. That's the real value
of testing with a deliberately partial, multi-format submission instead of an empty or a fully
correct one: it's the only way these three would have surfaced before a real student hit them.

Open item: `grading/rubrics/` only has `lab1.md`. lab2-8, assignment2, and final-project rubric files should be written before real student grading begins, so Stage 2 has a fixed point breakdown to work from instead of an estimate each time.
