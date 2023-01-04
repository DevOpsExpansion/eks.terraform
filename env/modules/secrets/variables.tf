variable "name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "service_account_name" {
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

variable "oidc_provider_arn" {
  type = string
}

variable "secret" {
  type = map(string)
}
