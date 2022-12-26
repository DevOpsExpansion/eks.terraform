locals {
  name = "demo"

  aws_region  = module.dotenv.result.AWS_REGION
  aws_profile = "sandbox"

  aws_default_tags = {
    Managed = "By Terraform"
    Project = local.name
  }
}
