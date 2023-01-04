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

variable "cluster_name" {
  type = string
}
variable "cluster_oidc_provider_arn" {
  type = string
}

variable "mongodbatlas_project_id" {
  type = string
}
variable "mongodbatlas_cluster_name" {
  type = string
}
