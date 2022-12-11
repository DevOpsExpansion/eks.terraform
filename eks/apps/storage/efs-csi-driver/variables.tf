variable "name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "chart_version" {
  type    = string
  default = "2.3.4"
}

variable "oidc_provider_arn" {
  type = string
}

variable "dist" {
  type    = bool
  default = false
}
