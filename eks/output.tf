output "ingress_alb_hostname" {
  value = module.ingress.alb_hostname
}

output "eks_nodegroups" {
  value = module.cluster.eks_managed_node_groups
}
