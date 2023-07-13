module "lacework_oci_cfg_integration" {
  source     = "../.."
  create     = true
  tenancy_id = var.tenancy_ocid
  user_email = "example@example.com"
}

variable "tenancy_ocid" {
  type = string
}
