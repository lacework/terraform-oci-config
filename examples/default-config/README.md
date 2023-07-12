# Default Example

This is an example of using the Terraform module for Lacework CSPM integration.

```hcl
module "lacework_oci_cfg_integration" {
  source = "../.."
  create = true
  tenancy_id = var.tenancy_ocid
}

variable "tenancy_ocid" {
  type = string
}
```
