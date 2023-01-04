module "secrets" {
  source = "./modules/secrets"

  name                 = "${var.name}-${var.prefix}"
  namespace            = "dev"
  service_account_name = "server"

  oidc_provider_arn = var.cluster_oidc_provider_arn

  secret = {
    CONNECTION_URL = module.database_user.connection_strings[var.mongodbatlas_cluster_name]
    DATABASE_NAME  = var.name
    PORT           = 8080
  }
}
