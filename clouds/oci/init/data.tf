data "oci_identity_tenancy" "main" {
  tenancy_id = var.tenancy_ocid
}