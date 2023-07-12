module "lacework_oci_cfg_integration" {
  source = "../.."
  create = false
  tenancy_id = var.tenancy_ocid
}

variable "tenancy_ocid" {
  type = string
}
