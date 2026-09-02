packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "web" {
  ami_name      = "acs730-lab6-web-{{timestamp}}"
  instance_type = var.instance_type
  region        = "us-east-1"

  source_ami_filter {
    filters = {
      name                = "al2023-ami-*-x86_64"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["137112412989"]
    most_recent = true
  }

  ssh_username = "ec2-user"
}

build {
  sources = ["source.amazon-ebs.web"]

  provisioner "shell" {
    inline = ["sudo dnf install -y httpd", "sudo systemctl enable httpd"]
  }
}
