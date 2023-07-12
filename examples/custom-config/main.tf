module "lacework_oci_cfg_integration" {
  source = "../.."
  create = true
  tenancy_id = var.tenancy_ocid
  base_name = "lacework_example_base"
  user_name = "lacework_example_user"
  group_name = "lacework_example_group"
  policy_name = "lacework_policy_example"
  user_email = "example@example.com"
  integration_name = "example_integration"
  freeform_tags = {"example_tag": "example_value"}
}

variable "tenancy_ocid" {
  type = string
}
