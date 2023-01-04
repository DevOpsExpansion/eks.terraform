terraform {
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.6.1"
    }
  }
}

data "mongodbatlas_cluster" "main" {
  for_each = toset(var.scopes)

  name       = each.value
  project_id = var.project_id
}
