locals {
  repo       = "https://grafana.github.io/helm-charts"
  chart_name = "grafana"
}

resource "helm_release" "grafana" {
  repository = local.repo
  chart      = local.chart_name
  version    = var.chart_version

  name             = var.name
  namespace        = var.namespace
  create_namespace = true
  values           = [var.values]
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
