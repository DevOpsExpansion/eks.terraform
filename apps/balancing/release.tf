locals {
  repo       = "https://aws.github.io/eks-charts"
  chart_name = "aws-load-balancer-controller"
}

resource "helm_release" "elb" {
  repository = local.repo
  chart      = local.chart_name
  version    = var.chart_version

  name      = var.name
  namespace = var.namespace

  values = [
    yamlencode({
      clusterName = var.cluster_name
      serviceAccount = {
        create = true
        name   = var.name
        annotations = {
          "eks.amazonaws.com/role-arn" : module.irsa.iam_role_arn
        }
      }
    })
  ]
}
