resource "github_actions_organization_secret" "aws_access_key_id" {
  visibility = "private"

  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = module.dotenv.result.AWS_ACCESS_KEY_ID
}

resource "github_actions_organization_secret" "aws_secret_access_key" {
  visibility = "private"

  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = module.dotenv.result.AWS_SECRET_ACCESS_KEY
}

resource "github_actions_organization_secret" "aws_region" {
  visibility = "private"

  secret_name     = "AWS_REGION"
  plaintext_value = module.dotenv.result.AWS_REGION
}

