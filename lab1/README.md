# Lab 1 — Git, GitHub, and the AWS CLI

Two wrapper scripts for provisioning an EC2 instance and a security group via the AWS CLI, matching the Week 1 lab.

- `scripts/create-instance.sh` — launches a t3.micro EC2 instance using the current Amazon Linux 2023 AMI, with `LabInstanceProfile` attached.
- `scripts/create-security-group.sh` — creates a security group opening SSH (port 22).
