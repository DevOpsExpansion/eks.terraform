module "database_user" {
  source = "../modules/atlas/rbac"

  project_id = var.mongodbatlas_project_id

  username = var.name

  roles = {
    dbAdmin   = "dev"
    readWrite = "dev"
  }
  scopes = [var.mongodbatlas_cluster_name]
}
