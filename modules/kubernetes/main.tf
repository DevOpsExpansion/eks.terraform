module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.4.2"

  cluster_name    = var.cluster_name
  cluster_version = "1.23"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = var.networking.vpc_id
  subnet_ids = var.networking.private_subnet_ids

  enable_irsa = true
  cluster_addons = {
    aws-ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.ebs_csi_irsa.iam_role_arn
    }
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent              = true
      service_account_role_arn = module.vpc_cni_irsa.iam_role_arn
    }
  }

  cluster_encryption_config = {
    resources = ["secrets"]
  }


  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    disk_size      = 20
    instance_types = ["t2.micro", "t2.medium"]

    # Without this initial policy, the VPC CNI fails to assign IPs and nodes cannot join the cluster
    iam_role_attach_cni_policy = true
  }

  eks_managed_node_groups = {

    services = {
      name = "services"
      # use_name_prefix        = false

      desired_size = 1
      min_size     = 1
      max_size     = 5

      instance_types = ["t2.medium"]
      capacity_type  = "SPOT"
    }

    apps = {
      name = "apps"
      # use_name_prefix        = false

      desired_size = 1
      min_size     = 1
      max_size     = 4

      instance_types = ["t2.medium"]
      capacity_type  = "SPOT"
    }
  }

  # Fargate Profile(s)
  fargate_profiles = {
    default = {
      name = "default"
      selectors = [
        {
          namespace = "default"
        }
      ]
    }
  }

  manage_aws_auth_configmap = true

  aws_auth_roles = var.aws_auth_roles

  #   aws_auth_users = [
  #     {
  #       userarn  = "arn:aws:iam::66666666666:user/user1"
  #       username = "user1"
  #       groups   = ["system:masters"]
  #     },
  #     {
  #       userarn  = "arn:aws:iam::66666666666:user/user2"
  #       username = "user2"
  #       groups   = ["system:masters"]
  #     },
  #   ]

  #   aws_auth_accounts = [
  #     "777777777777",
  #     "888888888888",
  #   ]
}
