module "vpn_security_group" {
  # https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/4.9.0
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "${var.name}-OpenVPN"
  description = "OpenVPN access security group"


  vpc_id = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "TCP"
      description = "Allow SSH traffic"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
      description = "Allow HTTP traffic"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "TCP"
      description = "Allow HTTPS traffic"
    },
    {
      from_port   = 943
      to_port     = 943
      protocol    = "TCP"
      description = "Allow VPN TCP traffic"
    },
    {
      from_port   = 945
      to_port     = 945
      protocol    = "TCP"
      description = "Allow VPN TCP traffic"
    },
    {
      from_port   = 1194
      to_port     = 1194
      protocol    = "UDP"
      description = "Allow VPN UDP traffic"
    },
  ]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}
