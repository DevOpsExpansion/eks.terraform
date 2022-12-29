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
      version = "4.48.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.12.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
  }
}

provider "aws" {
  region = local.aws_region
  # profile    = local.aws_profile
  access_key = module.dotenv.result.AWS_ACCESS_KEY_ID
  secret_key = module.dotenv.result.AWS_SECRET_ACCESS_KEY

  default_tags {
    tags = local.aws_default_tags
  }
}

# Created for ACM certificates
# CloudFront supports US East (N. Virginia) Region only.
provider "aws" {
  region = local.aws_region
  # profile    = local.aws_profile
  access_key = module.dotenv.result.AWS_ACCESS_KEY_ID
  secret_key = module.dotenv.result.AWS_SECRET_ACCESS_KEY
  alias      = "virginia"

  default_tags {
    tags = local.aws_default_tags
  }
}

provider "github" {
  owner = module.dotenv.result.GITHUB_OWNER
  token = module.dotenv.result.GITHUB_TOKEN
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
      module.cluster.cluster_name,
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
        module.cluster.cluster_name,
      ]
    }
  }
}

module "dotenv" {
  source = "./tools/dotenv"

  filepath = "${path.root}/.env"
}

data "aws_region" "this" {}
data "aws_caller_identity" "this" {}
