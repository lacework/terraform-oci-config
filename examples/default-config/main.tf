module "lacework_oci_cfg_integration" {
  source = "../.."
  create = true
  tenancy_id = var.tenancy_ocid
}

variable "tenancy_ocid" {
  type = string
}
