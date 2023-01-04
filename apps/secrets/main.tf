locals {
  driver = {
    repo       = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
    chart_name = "secrets-store-csi-driver"
  }
  provider = {
    repo       = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
    chart_name = "secrets-store-csi-driver-provider-aws"
  }
}

resource "helm_release" "driver" {
  repository = local.driver.repo
  chart      = local.driver.chart_name
  version    = var.chart_versions.driver

  name      = var.names.driver
  namespace = var.namespace

  values = [
    yamlencode({
      syncSecret = { enabled = true }
    })
  ]
}


resource "helm_release" "provider" {
  repository = local.provider.repo
  chart      = local.provider.chart_name
  version    = var.chart_versions.provider

  name      = var.names.provider
  namespace = var.namespace
}
