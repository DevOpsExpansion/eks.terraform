module "cluster" {
  source = "./modules/kubernetes"

  cluster_name = local.name
  networking = {
    vpc_id             = module.vpc.vpc_id
    public_subnet_ids  = module.vpc.public_subnets
    private_subnet_ids = module.vpc.private_subnets
  }

  aws_auth_roles = [ {
    rolearn = module.github.role_arn
    username = "github"
    groups = [ "system:masters" ]
  } ]
}
