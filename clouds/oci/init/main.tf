# main.tf
terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

provider "oci" {
  region = var.region
}

# data.tf
data "oci_identity_tenancy" "main" {
  tenancy_id = var.tenancy_ocid
}

# output.tf
output "tenancy_name" {
  value = data.oci_identity_tenancy.main.name
}

# variables.tf
variable "region" {
  type    = string
  default = "uk-london-1"
}

variable "tenancy_ocid" {
  type = string
}
