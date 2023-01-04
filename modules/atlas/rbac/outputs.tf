output "connection_strings" {
  value     = { for cluster in data.mongodbatlas_cluster.main : cluster.name => "mongodb+srv://${mongodbatlas_database_user.main.username}:${mongodbatlas_database_user.main.password}@${split("mongodb+srv://", cluster.srv_address)[1]}" }
  sensitive = true
}
