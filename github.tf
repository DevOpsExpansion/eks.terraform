data "github_repositories" "repos" {
  query = "eks.demo org:DevOpsExpansion"
}

resource "github_actions_secret" "aws_region" {
  for_each = toset(data.github_repositories.repos.names)

  repository      = each.value
  secret_name     = "AWS_REGION"
  plaintext_value = module.dotenv.result.AWS_REGION
}

module "github" {
  source = "./modules/github"

  name  = "GitHub_Assume"
  owner = module.dotenv.result.GITHUB_OWNER
  repos = "eks.demo.*"

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  ]
}

resource "github_actions_secret" "aws_assume_role_arn" {
  for_each = toset(data.github_repositories.repos.names)

  repository      = each.value
  secret_name     = "AWS_ASSUME_ROLE_ARN"
  plaintext_value = module.github.role_arn
}