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

# Step 1 of the lab: intentionally reproduce an insecure bucket so tfsec has
# something real to catch (Task: "Reproduce the misconfiguration intentionally
# and confirm the check blocks it"). Fixing it is the next step -- not done yet.
resource "aws_s3_bucket" "evidence" {
  bucket = "acs730-lab7-evidence-bucket-demo"
}

resource "aws_s3_bucket_public_access_block" "evidence" {
  bucket                  = aws_s3_bucket.evidence.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
