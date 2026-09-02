# ACS730 Grading (Instructor-Only)

This repository is private infrastructure for the instructor. It never contains a token or secret that a student repository can see, and it never calls an LLM/AI API from within a GitHub Actions pipeline.

## How It Works (Two Separate Stages)

**Stage 1 — Automated, in GitHub Actions.** This pipeline only does mechanical, deterministic checking. It never judges quality and never assigns a grade.

1. **`roster.csv`** — one row per student: GitHub username, public HTTPS URL of their repository (created from the `acs730` template).
2. **`pull-submissions.yml`** — run manually (Actions tab → "Pull Student Submissions" → Run workflow), on push to `roster.csv`, or on the daily schedule. For each row in the roster, it fetches that student's default branch and force-pushes it into a `submissions/<username>` branch in *this* repository. No credentials are needed to read a public student repo, and pushing to this repo uses the automatic `GITHUB_TOKEN` GitHub Actions already provides.
3. **`run-tests.yml`** — triggers automatically once `pull-submissions.yml` finishes (via `workflow_run`, which works regardless of what token caused the pull). For every `submissions/*` branch, it checks out that branch and runs `scripts/run-tests.sh` against it: `terraform validate`, `docker build`, `ansible-playbook --syntax-check`, `kubectl apply --dry-run=client`, `tfsec`, and a git-history secret/state-file hygiene check -- whichever apply based on what files exist in each deliverable folder. Results (plain PASS/FAIL, with failing output attached) are written to `grading/results/<username>.md` and committed to `main` (not to the student's branch, since that branch gets force-overwritten on every pull).

**Stage 2 — Judgment, done by a human or a Claude Code session, never inside the pipeline.** Once test results exist, read them (and the actual submitted code) to produce the real grade:

```bash
# See what mechanically passed/failed for one student
gh api repos/leolu-teach/acs730-grading-v2/contents/grading/results/test-student.md --jq '.content' | base64 -d

# Or just look at the file directly on main after a pull
git show main:grading/results/test-student.md

# Read the actual submitted code for qualitative review
git show submissions/test-student:lab3/main.tf
```

A Claude Code session pointed at this repository (or a clone of it) can read both the results file and the underlying code, compare against the rubric files in `grading/rubrics/`, and produce a grade with reasoning -- exactly like a TA would, just faster. This is a deliberate separation: the automated pipeline never touches an AI API, so there is no API key to manage, rotate, or worry about leaking in Actions at all.

## One-Time Setup

- Set this repository to **private** (Settings → Danger Zone → Change visibility) — it will hold pulled student code.
- Fill in `roster.csv` with real students once enrollment is finalized.
- Add one rubric file per lab/assignment under `grading/rubrics/` (one example, `lab1.md`, is included) -- these are read by whoever does Stage 2 grading, not by the pipeline itself.

## Viewing Results

- **Mechanical test results:** `grading/results/<username>.md` on the `main` branch of this repo (one file per student, updated after every test run).
- **The student's actual submission:** their own `submissions/<username>` branch -- check it out to see everything they've done across every lab/assignment folder.
