terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.41.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "6.41.0"
    }
  }
  cloud {
    organization = "confio"

    workspaces {
      name = "platform-development"
    }
  }
}
