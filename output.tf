output "created" {
  value       = var.create
  description = "Was the OCI user created"
}

output "user_ocid" {
  value = var.create ? module.lacework_oci_credentials.user_ocid : ""
  description = "OCID of the user created for the Lacework integration"
}

output "group_ocid" {
  value = var.create ? module.lacework_oci_credentials.group_ocid : ""
  description = "OCID of the group created to manage permissions for the integration user"
}

output "policy_ocid" {
  value = var.create ? oci_identity_policy.lacework_policy[0].id : ""
  description = "OCID of the policy created to manage permissions for the integration user"
}

output "integration_guid" {
  value = var.create ? lacework_integration_oci_cfg.lacework_integration[0].intg_guid : ""
  description = "Unique identifier for the integration used in by Lacework"
}
