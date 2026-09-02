# Lab 7 Rubric — Security and Policy-as-Code (10 points)

- [ ] tfsec is configured as a required status check on pull requests (evidence/README) (3 pts)
- [ ] A real misconfiguration was intentionally reproduced and the check demonstrably blocked it (screenshot or README note) (3 pts)
- [ ] The misconfiguration was then fixed and the check passes clean (2 pts)
- [ ] The deploy role's `PowerUserAccess` was replaced with a scoped-down custom policy (1 pt)
- [ ] README explains what was found and fixed (1 pt)

Note for graders: `run-tests.sh` treats a HIGH/CRITICAL tfsec finding in this folder specifically as
a required-check FAIL (everywhere else it's informational only) -- a submission that stops after
reproducing the misconfiguration but before fixing it will correctly show as failing this check.
That's expected mid-lab, not a pipeline bug; award the "reproduce" item and withhold the "fix" item.
