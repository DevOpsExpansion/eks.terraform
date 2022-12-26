variable "s3" {
  type = object({
    website_endpoint = string
  })
}

variable "route53_record" {
  type = object({
    name    = string
    zone_id = string
  })
}
