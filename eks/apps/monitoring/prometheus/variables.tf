variable "name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "chart_version" {
  type = string

  validation {
    error_message = "Must be valid semantic version."
    condition     = can(regex("^(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?$", var.chart_version))
  }
}

variable "ingress" {
  type = object({
    enabled     = bool
    class_name  = string
    annotations = map(string)
    path        = string
    hosts       = list(string)
  })
  default = {
    enabled     = false
    class_name  = "nginx"
    annotations = {}
    hosts       = ["default.com"]
    path        = "/"
  }
}

variable "dist" {
  type    = bool
  default = false
}
