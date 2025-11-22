# main.tf
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "europe-west2"
  zone    = "europe-west2-a"
}


resource "google_artifact_registry_repository" "instantinfra" {
    location = var.region
    repository_id = "${var.prefix}-gar-ii"
    format = "DOCKER"
}
