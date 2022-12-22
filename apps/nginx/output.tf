output "alb_hostname" {
  description = "Hostname of the load balancer created by the chart. Can be used for Route53 CNAME record"
  value       = data.kubernetes_service.alb.status.0.load_balancer.0.ingress.0.hostname
}
