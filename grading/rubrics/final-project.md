# Final Project Rubric — Integrate the Pipeline You Built All Term (100 points)

Full outline and submission requirements: `course-redesign/assessments/FinalProject.md`.

| Section | Points |
|---|---|
| Terraform provisioning (module + multi-environment) | 15 |
| Configuration management (Ansible and/or Packer) | 15 |
| Kubernetes deployment via the CI/CD pipeline | 15 |
| Automatic deploy on merge, zero stored AWS credentials | 10 |
| Monitoring signal (alarm or dashboard) | 10 |
| Required security scan blocking on findings | 10 |
| REPORT.md (architecture, design decision, retrospective) | 15 |
| Live demo | 10 |
| **Total** | **100** |

Note for graders: "Required security scan blocking on findings" is a student-owned CI setting (their
own `final-project-deploy.yml` treating tfsec/checkov as a required check), not something
`run-tests.sh` grants automatically -- it only ever runs tfsec informationally for this folder.
Verify by reading the student's own workflow file, not the mechanical test results.
