locals {
  repo       = "https://kubernetes.github.io/ingress-nginx"
  chart_name = "ingress-nginx"
}

resource "helm_release" "nginx" {
  repository = local.repo
  chart      = local.chart_name
  version    = var.chart_version

  name             = var.name
  namespace        = var.namespace
  create_namespace = true

  timeout = 600
}
