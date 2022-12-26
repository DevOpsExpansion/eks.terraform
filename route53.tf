data "aws_route53_zone" "main" {
  name         = module.dotenv.result.AWS_ROUTE_53_ZONE_NAME
  private_zone = false
}
