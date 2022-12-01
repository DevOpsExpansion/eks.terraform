resource "null_resource" "values" {
  triggers = {
    values = var.trigger
  }

  provisioner "local-exec" {
    command    = "helm pull --repo ${var.repo} ${var.chart_name} --version ${var.chart_version} --untar --untardir ${var.path}/"
    on_failure = continue
    when       = create
  }
}
