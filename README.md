# ACS730 Grading (Instructor-Only)

This repository is private infrastructure for the instructor. It never contains a token or secret that a student repository can see.

## How it works

1. **`roster.csv`** — one row per student: GitHub username, public HTTPS URL of their repository (created from the `acs730` template).
2. **`pull-submissions.yml`** — run manually (Actions tab → "Pull Student Submissions" → Run workflow) or on the daily schedule. For each row in the roster, it fetches that student's default branch and force-pushes it into a `submissions/<username>` branch in *this* repository. No credentials are needed to read a public student repo, and pushing to this repo uses the automatic `GITHUB_TOKEN` GitHub Actions already provides — nothing custom to manage.
3. **`grade.yml`** — runs whenever a `submissions/*` branch updates. Checks out that branch and asks Claude (via `anthropics/claude-code-action`) to grade one folder against the matching rubric in `grading/rubrics/`, writing a report to `grading/results/`.

## One-time setup

- Set this repository to **private** (Settings → Danger Zone → Change visibility) — it will hold pulled student code.
- Add an `ANTHROPIC_API_KEY` secret (Settings → Secrets and variables → Actions) for `grade.yml` to use.
- Fill in `roster.csv` with real students once enrollment is finalized.
- Add one rubric file per lab/assignment under `grading/rubrics/` (one example, `lab1.md`, is included).

## Viewing results

Each student's full submission is on its own `submissions/<username>` branch — check that branch out to see everything they've done across every lab/assignment folder. Grading reports land in `grading/results/` on that same branch after `grade.yml` runs, and are also uploaded as a workflow run artifact.
