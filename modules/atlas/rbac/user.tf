resource "mongodbatlas_database_user" "main" {
  username = var.username
  password = var.random_password ? random_password.main[0].result : var.password

  project_id         = var.project_id
  auth_database_name = "admin"

  dynamic "roles" {
    for_each = var.roles
    iterator = role
    content {
      role_name     = role.key
      database_name = role.value
    }
  }

  dynamic "scopes" {
    for_each = toset(var.scopes)
    iterator = scope
    content {
      name = scope.value
      type = "CLUSTER"
    }
  }

  dynamic "labels" {
    for_each = var.labels
    iterator = label
    content {
      key   = label.key
      value = label.value
    }
  }
}

resource "random_password" "main" {
  count = var.random_password ? 1 : 0

  length  = 16
  special = false
}
