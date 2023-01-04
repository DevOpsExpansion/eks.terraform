module "atlas" {
  source = "./modules/atlas"

  organization_id = module.dotenv.result.MONGODB_ATLAS_ORG_ID
  project_name    = "shurgentum"

  cluster_name   = "demo"
  cluster_region = module.dotenv.result.MONGODB_ATLAS_REGION

  database_access = {
    cidr_blocks = ["0.0.0.0/0"]
    ips         = []
  }
}
