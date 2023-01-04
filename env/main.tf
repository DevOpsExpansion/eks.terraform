terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.12.0"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.6.1"
    }
  }
}
