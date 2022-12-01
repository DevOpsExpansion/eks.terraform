resource "helm_release" "grafana" {
  repository = local.repo
  chart      = local.chart_name
  version    = var.chart_version

  name             = var.name
  namespace        = var.namespace
  create_namespace = true

  values = [yamlencode({
    ingress = {
      enabled          = var.ingress.enabled
      ingressClassName = var.ingress.class_name
      annotations      = var.ingress.annotations
      hosts            = var.ingress.hosts
      path             = var.ingress.path
    }
    env = {
      GF_SERVER_ROOT_URL            = "/grafana"
      GF_SERVER_SERVE_FROM_SUB_PATH = "true"
    }
    datasources = {
      "datasources.yaml" = {
        apiVersion = 1
        datasources = [{
          name      = "Prometheus"
          type      = "prometheus"
          url       = "http://prometheus-server.monitoring.svc.cluster.local/prometheus"
          access    = "proxy"
          isDefault = true
        }]
      }
    }
  })]
}

module "dist" {
  source = "../../../helpers/dist"
  count  = var.dist ? 1 : 0

  path    = "${path.module}/dist"
  trigger = helm_release.grafana.version

  repo          = local.repo
  chart_name    = local.chart_name
  chart_version = var.chart_version
}
