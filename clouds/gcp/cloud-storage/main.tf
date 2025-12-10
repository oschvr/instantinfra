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
  region  = var.region
  zone    = "europe-west2-a"
}

resource "google_storage_bucket" "instantinfra" {
  name          = "${var.prefix}-gcs"
  location      = upper(var.region)
  force_destroy = true
}

