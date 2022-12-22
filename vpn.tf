# module "openvpn" {
#   source = "./modules/openvpn"
#   name   = local.name

#   vpc_id    = module.vpc.vpc_id
#   subnet_id = module.vpc.public_subnets[0]

#   key_name = "local.keys.openvpn"

#   route53_zone_id     = aws_route53_zone.main.zone_id
#   route53_record_name = "connect.${aws_route53_zone.main.name}"
# }
