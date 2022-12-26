module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = "${local.name}-vpc"
  cidr = "10.0.0.0/16"

  azs = ["${local.aws_region}a", "${local.aws_region}b", "${local.aws_region}c"]

  public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  public_subnet_tags = {
    "kubernetes.io/role/elb"              = 1
    "kubernetes.io/cluster/${local.name}" = "owned"
  }

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"     = 1
    "kubernetes.io/cluster/${local.name}" = "owned"
  }

  map_public_ip_on_launch = false

  one_nat_gateway_per_az = true
  enable_nat_gateway     = true
  enable_dns_support     = true
  enable_dns_hostnames   = true
}
