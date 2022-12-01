terraform {
  required_version = "1.3.3"

  # backend "s3" {
  #   bucket  = "terraform-088440794684"
  #   key     = "tfstate/main.tfstate"
  #   region  = "us-east-1"
  #   profile = "sandbox"
  # }

  backend "local" {
    path = "./.terraform/state/terraform.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.37.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.7.1"
    }
  }
}

provider "aws" {
  region  = local.aws_region
  profile = local.aws_profile

  default_tags {
    tags = local.aws_default_tags
  }
}

# Created for ACM certificates
# CloudFront supports US East (N. Virginia) Region only.
provider "aws" {
  region  = local.aws_region
  profile = local.aws_profile
  alias   = "virginia"

  default_tags {
    tags = local.aws_default_tags
  }
}

provider "kubernetes" {
  host                   = module.cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.cluster.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = [
      "eks",
      "get-token",
      "--region",
      local.aws_region,
      "--profile",
      local.aws_profile,
      "--cluster-name",
      module.cluster.cluster_id,
    ]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.cluster.cluster_endpoint
    cluster_ca_certificate = base64decode(module.cluster.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      # This requires the awscli to be installed locally where Terraform is executed
      args = [
        "eks",
        "get-token",
        "--region",
        local.aws_region,
        "--profile",
        local.aws_profile,
        "--cluster-name",
        module.cluster.cluster_id,
      ]
    }
  }
}


data "aws_region" "this" {}
data "aws_caller_identity" "this" {}
