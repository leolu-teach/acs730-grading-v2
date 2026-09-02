terraform {
  required_version = "~> 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "lab3_demo" {
  name        = "acs730-lab3-demo"
  description = "Created by Terraform in Lab 3"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# NOTE (bug, left in intentionally for grading-pipeline testing):
# this references a variable that is never declared anywhere in this
# configuration, which `terraform validate` should catch.
resource "aws_instance" "demo" {
  ami           = "ami-0123456789abcdef0"
  instance_type = var.instance_type
}
