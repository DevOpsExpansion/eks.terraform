variable "name" {
  description = "Name (prefix) of AWS resources to create."
  type        = string
}

variable "owner" {
  description = "Owner of repositories to grant permissions to."
  type        = string
}

variable "repos" {
  description = "Filter, which determines which repositories to grant permissions to."
  type        = string
  default     = "*"
}

variable "oidc_auditory" {
  description = "Client id, commonly known as auditory"
  type        = string
  default     = "sts.amazonaws.com"
}

variable "oidc_url" {
  description = "URL of github OIDC provider endpoint."
  type        = string
  default     = "token.actions.githubusercontent.com"
}

variable "attach_policy" {
  type    = bool
  default = false
}

variable "policy" {
  description = "Policy to attach to IAM role."
  type        = string
  default     = ""
}

variable "policy_arns" {
  description = "List of policy ARNs to attach to IAM role"
  type        = list(string)
  default     = []
}