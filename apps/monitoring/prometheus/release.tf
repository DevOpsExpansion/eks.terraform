locals {
  repo       = "https://prometheus-community.github.io/helm-charts"
  chart_name = "prometheus"
}

resource "helm_release" "prometheus" {
  repository = local.repo
  chart      = local.chart_name
  version    = var.chart_version

  name             = var.name
  namespace        = var.namespace
  create_namespace = true
  wait             = false

  values = [var.values]
}

module "dist" {
  source = "../../../helpers/dist"
  count  = var.dist ? 1 : 0

  path    = "${path.module}/dist"
  trigger = helm_release.prometheus.version

  repo          = local.repo
  chart_name    = local.chart_name
  chart_version = var.chart_version
}
