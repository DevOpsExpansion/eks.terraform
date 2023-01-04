module "secrets_access_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.9.2"

  role_name_prefix                 = "secrets-access-irsa"
  attach_external_secrets_policy = true

  external_secrets_secrets_manager_arns = [ aws_secretsmanager_secret.main.arn ]
  external_secrets_ssm_parameter_arns = var.ssm_parameter_arn

  oidc_providers = {
    main = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["${var.namespace}:${var.service_account_name}"]
    }
  }
}
