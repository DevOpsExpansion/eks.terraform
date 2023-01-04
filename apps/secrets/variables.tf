variable "names" {
  type = object({
    driver   = string
    provider = string
  })
  default = {
    driver   = "csi-secrets-store"
    provider = "secrets-provider-aws"
  }
}

variable "namespace" {
  type    = string
  default = "kube-system"
}

variable "chart_versions" {
  type = object({
    driver   = string
    provider = string
  })
  default = {
    driver   = "1.3.0"
    provider = "0.2.0"
  }
}

variable "oidc_provider_arn" {
  type = string
}

variable "secrets_manager_arns" {
  type    = list(string)
  default = ["arn:aws:secretsmanager:*:*:secret:*"]
}

variable "ssm_parameter_arn" {
  type    = list(string)
  default = ["arn:aws:ssm:*:*:parameter/*"]
}
