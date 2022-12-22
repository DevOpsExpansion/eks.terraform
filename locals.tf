locals {
  name = "demo"

  aws_region  = "us-east-1"
  aws_profile = "sandbox"

  aws_default_tags = {
    Managed = "By Terraform"
    Project = local.name
  }
}
