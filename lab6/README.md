# Lab 6 - Configuration Management with Ansible, and Golden AMIs

- `ansible/playbook.yml` - idempotent-style playbook: installs httpd, deploys a templated index page, enables the service.
- `ansible/inventory.ini` - static inventory (placeholder IP, replace after Terraform apply).
- `packer/web.pkr.hcl` - golden AMI template using the same install step. **Not yet validated** -- still working through a Packer error before comparing boot time against the Ansible path.
