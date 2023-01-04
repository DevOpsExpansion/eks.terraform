variable "name" {
  type    = string
  default = "aws-load-balancer-controller"
}

variable "namespace" {
  type    = string
  default = "kube-system"
}

variable "chart_version" {
  type    = string
  default = "1.4.6"
}

variable "cluster_name" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}
