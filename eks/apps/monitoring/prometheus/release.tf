resource "helm_release" "prometheus" {
  repository = local.repo
  chart      = local.chart_name
  version    = var.chart_version

  name             = var.name
  namespace        = var.namespace
  create_namespace = true
  wait             = false

  values = [yamlencode({
    server = {
      prefixURL = "/prometheus"
      extraArgs = {
        # For some reason this arg isn't added by helm
        "web.external-url" = "http:/prometheus/"
      }
      ingress = {
        enabled          = var.ingress.enabled
        ingressClassName = var.ingress.class_name
        annotations      = var.ingress.annotations
        hosts            = var.ingress.hosts
        path             = var.ingress.path
      }
      persistentVolume = {
        storageClass = "gp2"
      }
    }
  })]
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
