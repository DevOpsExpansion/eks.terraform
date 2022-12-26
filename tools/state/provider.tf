terraform {
  required_version = "~>1.3.3"
  backend "local" {
    path = "./.terraform/state/terraform.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.48.0"
    }
  }
}


provider "aws" {
  region  = "us-east-1"
  profile = "sandbox"
  default_tags {
    tags = {
      Project    = "sandbox"
      managed_by = "Terraform/setup"
    }
  }
}
