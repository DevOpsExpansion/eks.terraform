variable "name" {
  description = "Environment name"
  type        = string
}

variable "prefix" {
  type = string
}

variable "route53" {
  type = object({
    zone_id = string
    name    = string
  })
}
