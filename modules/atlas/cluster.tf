resource "mongodbatlas_project" "main" {
  name   = var.project_name
  org_id = var.organization_id
}

resource "mongodbatlas_cluster" "main" {
  project_id = mongodbatlas_project.main.id
  name       = var.cluster_name

  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name        = var.cluster_region
  provider_instance_size_name = "M0"
}

resource "mongodbatlas_project_ip_access_list" "cidrs" {
  for_each   = toset(var.database_access.cidr_blocks)
  project_id = mongodbatlas_project.main.id
  cidr_block = each.value
  comment    = "CIDR"
}

resource "mongodbatlas_project_ip_access_list" "ips" {
  for_each   = toset(var.database_access.ips)
  project_id = mongodbatlas_project.main.id
  ip_address = each.value
  comment    = "Address"
}
