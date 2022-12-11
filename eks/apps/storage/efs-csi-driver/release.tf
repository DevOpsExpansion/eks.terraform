locals {
  repo       = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
  chart_name = "aws-efs-csi-driver"
}

resource "helm_release" "efs_csi_driver" {
  repository = local.repo
  chart      = local.chart_name
  version    = var.chart_version

  name             = var.name
  namespace        = var.namespace
  create_namespace = true
}

module "dist" {
  source = "../../../helpers/dist"
  count  = var.dist ? 1 : 0

  path    = "${path.module}/dist"
  trigger = helm_release.efs_csi_driver.version

  repo          = local.repo
  chart_name    = local.chart_name
  chart_version = var.chart_version
}
