module "lacework_oci_cfg_integration" {
  source     = "../.."
  create     = true
  tenancy_id = var.tenancy_ocid
  user_email = var.user_email
}

variable "tenancy_ocid" {
  type = string
}

variable "user_email" {
	type = string
	default = "example@example.com"
}
