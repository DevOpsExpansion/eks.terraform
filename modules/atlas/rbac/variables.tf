variable "project_id" {
  type = string
}


variable "username" {
  type = string
}

variable "password" {
  type    = string
  default = null
}

variable "random_password" {
  type    = bool
  default = true
}

variable "roles" {
  type = map(string)
}

variable "scopes" {
  type = list(string)
}

variable "labels" {
  type    = map(string)
  default = {}
}


