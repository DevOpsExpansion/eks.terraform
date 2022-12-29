module "autoscaler" {
  source = "./apps/autoscaler"

  name          = "autoscaler"
  namespace     = "autoscaling"
  chart_version = "9.21.0"

  cluster_name      = module.cluster.cluster_name
  oidc_provider_arn = module.cluster.oidc_provider_arn
}

module "ingress" {
  source = "./apps/nginx"

  name          = "nginx"
  namespace     = "ingress"
  chart_version = "4.4.0"
}

# module "efs_csi_driver" {
#   source = "./apps/storage/efs-csi-driver"

#   name          = "efs-csi-driver"
#   namespace     = "efs-csi-driver"
#   chart_version = "2.3.4"

#   oidc_provider_arn = module.cluster.oidc_provider_arn

#   dist = true
# }

# module "prometheus" {
#   source = "./apps/monitoring/prometheus"

#   name          = "prometheus"
#   namespace     = "monitoring"
#   chart_version = "18.1.0"

#   values = yamlencode({
#     "prometheus-node-exporter" = {
#       # Not schedule a node exporter to t2.micro nodes,
#       # since it have litmited treshold for ENI
#       affinity = {
#         nodeAffinity = {
#           requiredDuringSchedulingIgnoredDuringExecution = {
#             nodeSelectorTerms = [{
#               matchExpressions = [{
#                 key      = "node.kubernetes.io/instance-type"
#                 operator = "NotIn"
#                 values   = ["t2.micro"]
#               }]
#             }]
#           }
#         }
#       }
#     }
#     server = {
#       prefixURL = "/prometheus"
#       extraArgs = {
#         # For some reason this arg isn't added by helm
#         "web.external-url" = "http:/prometheus/"
#       }
#       ingress = {
#         enabled          = true
#         ingressClassName = "nginx"
#         hosts            = [module.ingress.alb_hostname]
#         path             = "/prometheus"
#       }
#       persistentVolume = {
#         storageClass = "gp2"
#       }
#     }
#   })

#   dist = true

#   depends_on = [
#     module.ingress
#   ]
# }

# module "grafana" {
#   source = "./apps/monitoring/grafana"

#   name          = "grafana"
#   namespace     = "monitoring"
#   chart_version = "6.43.1"

#   values = yamlencode({
#     env = {
#       GF_SERVER_ROOT_URL            = "/grafana"
#       GF_SERVER_SERVE_FROM_SUB_PATH = "true"
#     }
#     ingress = {
#       enabled          = true
#       ingressClassName = "nginx"
#       annotations      = {}
#       hosts            = [module.ingress.alb_hostname]
#       path             = "/grafana"
#     }
#     datasources = {
#       "datasources.yaml" = {
#         apiVersion = 1
#         datasources = [{
#           name      = "Prometheus"
#           type      = "prometheus"
#           url       = "http://prometheus-server.monitoring.svc.cluster.local/prometheus"
#           access    = "proxy"
#           isDefault = true
#         }]
#       }
#     }
#   })

#   dist = true

#   depends_on = [
#     module.ingress,
#     module.prometheus
#   ]
# }
