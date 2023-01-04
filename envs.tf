module "env-dev" {
  source = "./env"

  name   = "dev"
  prefix = local.name

  route53 = {
    name    = data.aws_route53_zone.main.name
    zone_id = data.aws_route53_zone.main.zone_id
  }

  cluster_name              = module.cluster.cluster_name
  cluster_oidc_provider_arn = module.cluster.oidc_provider_arn

  mongodbatlas_project_id   = module.atlas.project_id
  mongodbatlas_cluster_name = module.atlas.cluster_name
}
