# Lab 6 Rubric — Configuration Management with Ansible, and Golden AMIs (10 points)

- [ ] Playbook is written in an idempotent style using proper modules, and includes at least one templated file (3 pts)
- [ ] Dynamic inventory (or a clearly documented placeholder) targets Terraform-created instances (2 pts)
- [ ] The Ansible step is added to the deploy workflow, running immediately after `terraform apply` (2 pts)
- [ ] `packer validate` passes on the golden AMI template (2 pts)
- [ ] README/notes compare boot-to-ready time, Ansible-converge-on-boot vs. golden AMI (1 pt)
