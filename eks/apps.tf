module "autoscaler" {
  source = "./apps/autoscaler"

  name      = "autoscaler"
  namespace = "autoscaling"

  cluster_id        = module.cluster.cluster_id
  oidc_provider_arn = module.cluster.oidc_provider_arn
}

module "ingress" {
  source = "./apps/nginx"

  name      = "nginx"
  namespace = "ingress"
}

module "prometheus" {
  source = "./apps/monitoring/prometheus"

  name          = "prometheus"
  namespace     = "monitoring"
  chart_version = "18.1.0"

  ingress = {
    enabled     = true
    class_name  = "nginx"
    annotations = {}
    hosts       = [module.ingress.alb_hostname]
    path        = "/prometheus"
  }

  dist = true

  depends_on = [
    module.ingress
  ]
}

module "grafana" {
  source = "./apps/monitoring/grafana"

  name          = "grafana"
  namespace     = "monitoring"
  chart_version = "6.43.1"

  dist = true

  ingress = {
    enabled     = true
    class_name  = "nginx"
    annotations = {}
    hosts       = [module.ingress.alb_hostname]
    path        = "/grafana"
  }

  depends_on = [
    module.ingress,
    module.prometheus
  ]
}
