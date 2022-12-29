locals {
  github_secrets = {
    client = {
      DISTRIBUTION_ID  = module.cloudfront.distribution_id
      S3_BUCKET_NAME   = module.frontend.s3_bucket_id
      S3_BUCKET_REGION = module.frontend.s3_bucket_region

    }
    server = {
      ECR_REPOSITORY = split("/", module.ecr.repository_url)[1]
    }
  }
}

data "github_repository" "client" {
  name = "eks.demo.client"
}
data "github_repository" "server" {
  name = "eks.demo.server"
}

resource "github_actions_secret" "client" {
  for_each = local.github_secrets.client

  repository = data.github_repository.client.name

  secret_name     = each.key
  plaintext_value = each.value
}

resource "github_actions_secret" "server" {
  for_each = local.github_secrets.server

  repository = data.github_repository.server.name

  secret_name     = each.key
  plaintext_value = each.value
}

# For GitHub paid plans

# resource "github_repository_environment" "client" {
#   environment = var.name
#   repository = data.github_repository.client.name
# }

# resource "github_repository_environment" "server" {
#   environment = var.name
#   repository = data.github_repository.server.name
# }

# resource "github_actions_environment_secret" "client" {
#     for_each = local.github_secrets.client

#   repository = data.github_repository.client.name
#   environment = github_repository_environment.client.environment


#   secret_name     = each.key
#   plaintext_value = each.value
# }

# resource "github_actions_environment_secret" "server" {
#     for_each = local.github_secrets.server

#   repository = data.github_repository.server.name
#   environment = github_repository_environment.server.environment


#   secret_name     = each.key
#   plaintext_value = each.value
# }
