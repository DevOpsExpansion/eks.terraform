module "env-dev" {
  source = "./env"

  name   = "dev"
  prefix = local.name

  route53 = {
    name    = data.aws_route53_zone.main.name
    zone_id = data.aws_route53_zone.main.zone_id
  }
}
