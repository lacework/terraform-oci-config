# Default Example

This is an example of using the Terraform module for Lacework CSPM integration.
You need to provide credentials to the OCI provider and the Lacework provider.
If you already have your OCI and Lacework CLI tools installed and configured,
the providers will be able to access the same credentials as those CLI tools.
Otherwise, see the [Lacework provider docs](https://registry.terraform.io/providers/lacework/lacework/latest/docs)
and the [OCI provider docs](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm)
for a list of options of how to provide credentials to those providers.

```hcl
module "lacework_oci_cfg_integration" {
  source = "lacework/config/oci"
  create = true
  tenancy_id = var.tenancy_ocid
  user_email = "example@example.com"
}

variable "tenancy_ocid" {
  type = string
}
```
