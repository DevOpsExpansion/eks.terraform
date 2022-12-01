resource "helm_release" "autoscaler" {
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = "9.21.0"

  name             = var.name
  namespace        = var.namespace
  create_namespace = true

  values = [
    yamlencode({
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

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_id
  }
}
