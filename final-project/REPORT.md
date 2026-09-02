# Final Project Report (Work in Progress)

## Architecture Overview

Two services: a containerized frontend (reusing the Lab 4 image, deployed to Kubernetes) and a
small VM-based API service (provisioned with Terraform, configured with Ansible). Terraform stands
up the dev security group for the API instance; the Kubernetes manifests deploy and expose the
frontend.

(Not yet done: staging/prod environments, the deploy-on-merge workflow, the monitoring signal, the
required security scan gate, the design-decision writeup, "what I'd do differently," and the course
retrospective.)
