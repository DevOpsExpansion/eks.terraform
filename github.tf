data "github_repositories" "repos" {
  query = "eks.demo org:DevOpsExpansion"
}

resource "github_actions_secret" "aws_access_key_id" {
  for_each = toset(data.github_repositories.repos.names)

  repository      = each.value
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = module.dotenv.result.AWS_ACCESS_KEY_ID
}

resource "github_actions_secret" "aws_secret_access_key" {
  for_each = toset(data.github_repositories.repos.names)

  repository      = each.value
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = module.dotenv.result.AWS_SECRET_ACCESS_KEY
}

resource "github_actions_secret" "aws_region" {
  for_each = toset(data.github_repositories.repos.names)

  repository      = each.value
  secret_name     = "AWS_REGION"
  plaintext_value = module.dotenv.result.AWS_REGION
}
