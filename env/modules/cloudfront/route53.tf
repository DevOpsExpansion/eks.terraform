resource "aws_route53_record" "cloudfront" {
  zone_id = var.route53_record.zone_id

  name = var.route53_record.name
  type = "A"


  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "4.3.1"

  domain_name = var.route53_record.name
  zone_id     = var.route53_record.zone_id

  wait_for_validation = true
}
