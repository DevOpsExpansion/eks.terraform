variable "cluster_name" {
  type = string
}

variable "networking" {
  type = object({
    vpc_id             = string
    public_subnet_ids  = list(string)
    private_subnet_ids = list(string)
  })
}

variable "aws_auth_roles" {
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}