data "kubernetes_service" "alb" {
  metadata {
    name      = "${var.name}-ingress-nginx-controller"
    namespace = var.namespace
  }

  depends_on = [
    helm_release.nginx
  ]
}
