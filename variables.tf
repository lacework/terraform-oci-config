# Required

variable "tenancy_id" {
  type = string
  description = "OCID of the OCI tenancy to be integrated with Lacework"
}

variable "user_email" {
  type = string
  description = "Email associated with the created user"
}

# Optional

variable "create" {
  type = bool
  default = true
  description = "Set to false to prevent module from creating any resources"
}

variable "freeform_tags" {
  type = map
  default = {}
  description = "freeform tags for the resources created for Lacework CSPM integration"
}

variable "name_prefix" {
	type = string
	default = "lacework_cspm_integration"
	description = "The OCI resources will have the names $${name_prefix}_{user,group,policy}"
}

variable "user_name" {
  type = string
  default = ""
  description = "Name of the IAM user used for Lacework integration (overrides name_prefix)"
}

variable "group_name" {
  type = string
  default = ""
  description = "Name of the IAM group for the Lacework user (overrides name_prefix)"
}

variable "policy_name" {
  type = string
  default = ""
  description = "Name of the policy that governs the Lacework user's permissions (overrides name_prefix)"
}

variable "integration_name" {
	type = string
	default = "OCI CSPM Integration"
	description = "Label for the OCI integration used within the Lacework platform"
}

