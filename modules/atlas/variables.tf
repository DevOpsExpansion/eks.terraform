variable "organization_id" {
  type = string
}

variable "project_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_region" {
  type = string
}

variable "database_access" {
  type = object({
    ips         = list(string)
    cidr_blocks = list(string)
  })
}
