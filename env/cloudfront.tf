module "cloudfront" {
  source = "./modules/cloudfront"

  s3 = {
    website_endpoint = module.frontend.s3_bucket_website_endpoint
  }

  route53_record = {
    name    = "${var.name}.${var.route53.name}"
    zone_id = var.route53.zone_id
  }
}
