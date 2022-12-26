locals {
  origin_id_frontend = "frontend"
}

resource "aws_cloudfront_distribution" "main" {
  enabled = true
  aliases = [var.route53_record.name]

  viewer_certificate {
    acm_certificate_arn      = module.acm.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = ["RU", "IR"]
    }
  }


  default_root_object = "index.html"

  origin {
    domain_name = var.s3.website_endpoint
    origin_id   = local.origin_id_frontend

    custom_origin_config {
      http_port  = 80
      https_port = 443

      origin_protocol_policy = "http-only"
      origin_ssl_protocols = [
        "TLSv1.2"
      ]
    }
  }
  default_cache_behavior {
    compress         = true
    target_origin_id = local.origin_id_frontend

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
}
