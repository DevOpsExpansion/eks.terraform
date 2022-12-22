variable "name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "chart_version" {
  type = string
}

variable "values" {
  description = "Values in yamlencoded map (string) format to be passed to Helm."
  type        = string
  default     = ""
}

variable "dist" {
  type    = bool
  default = false
}
