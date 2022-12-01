resource "helm_release" "nginx" {
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.4.0"

  name             = var.name
  namespace        = var.namespace
  create_namespace = true

  timeout = 6000
}
