module "lacework_oci_cfg_integration" {
  source           = "../.."
  create           = true
  tenancy_id       = var.tenancy_ocid
  user_email       = "example@example.com"
  name_prefix      = "lacework_example_prefix"
  user_name        = "lacework_example_user"
  group_name       = "lacework_example_group"
  policy_name      = "lacework_policy_example"
  integration_name = "example_integration"
  freeform_tags    = { "example_tag" : "example_value" }
}

variable "tenancy_ocid" {
  type = string
}
