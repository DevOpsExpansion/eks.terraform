locals {
  repo                    = "https://kubernetes.github.io/autoscaler"
  chart_name              = "cluster-autoscaler"
  k8s_serviceaccount_name = "cluster-autoscaler"
}

resource "helm_release" "autoscaler" {
  repository = local.repo
  chart      = local.chart_name
  version    = var.chart_version

  name             = var.name
  namespace        = var.namespace
  create_namespace = true

  values = [
    yamlencode({
      autoDiscovery = {
        clusterName = var.cluster_name
      }
      rbac = {
        serviceAccount = {
          create                       = true
          name                         = local.k8s_serviceaccount_name
          automountServiceAccountToken = true
          annotations = {
            "eks.amazonaws.com/role-arn" : module.autoscaler_irsa.iam_role_arn
          }
        }
      }
    })
  ]
}
