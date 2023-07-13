<a href="https://lacework.com"><img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600"></a>

# terraform-oci-config

[![GitHub release](https://img.shields.io/github/release/lacework/terraform-oci-config.svg)](https://github.com/lacework/terraform-<PROVIDER>-<NAME>/releases/)
[![Codefresh build status]( https://g.codefresh.io/api/badges/pipeline/lacework/terraform-modules%2Ftest-compatibility?type=cf-1&key=eyJhbGciOiJIUzI1NiJ9.NWVmNTAxOGU4Y2FjOGQzYTkxYjg3ZDEx.RJ3DEzWmBXrJX7m38iExJ_ntGv4_Ip8VTa-an8gBwBo)]( https://g.codefresh.io/pipelines/edit/new/builds?id=607e25e6728f5a6fba30431b&pipeline=test-compatibility&projects=terraform-modules&projectId=607db54b728f5a5f8930405d)

A Terraform Module for configuring a CSPM integration with Lacework for an OCI cloud
account.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_lacework"></a> [lacework](#requirement\_lacework) | >= 1.9.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | >= 5.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_lacework"></a> [lacework](#provider\_lacework) | >= 1.9.0 |
| <a name="provider_oci"></a> [oci](#provider\_oci) | >= 5.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lacework_oci_credentials"></a> [lacework\_oci\_credentials](#module\_lacework\_oci\_credentials) | lacework/iam-user/oci | >= 0.2.0 |

## Resources

| Name | Type |
|------|------|
| [lacework_integration_oci_cfg.lacework_integration](https://registry.terraform.io/providers/lacework/lacework/latest/docs/resources/integration_oci_cfg) | resource |
| [oci_identity_policy.lacework_policy](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_policy) | resource |
| [oci_identity_region_subscriptions.home_region](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_region_subscriptions) | data source |
| [oci_identity_tenancy.tenancy](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_tenancy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_base_name"></a> [base\_name](#input\_base\_name) | The OCI resources will have the names ${base\_name}\_{user,group,policy} | `string` | `"lacework_cspm_integration"` | no |
| <a name="input_create"></a> [create](#input\_create) | Set to false to prevent module from creating any resources | `bool` | `true` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | freeform tags for the resources created for Lacework CSPM integration | `map` | `{}` | no |
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | Name of the IAM group for the Lacework user (overrides base\_name) | `string` | `""` | no |
| <a name="input_integration_name"></a> [integration\_name](#input\_integration\_name) | Label for the OCI integration used within the Lacework platform | `string` | `"OCI CSPM Integration"` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name of the policy that governs the Lacework user's permissions (overrides base\_name) | `string` | `""` | no |
| <a name="input_tenancy_id"></a> [tenancy\_id](#input\_tenancy\_id) | OCID of the OCI tenancy to be integrated with Lacework | `string` | n/a | yes |
| <a name="input_user_email"></a> [user\_email](#input\_user\_email) | Email associated with the created user | `string` | `"lacework@lacework.net"` | no |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | Name of the IAM user used for Lacework integration (overrides base\_name) | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created"></a> [created](#output\_created) | Was the OCI user created |
| <a name="output_group_ocid"></a> [group\_ocid](#output\_group\_ocid) | OCID of the group created to manage permissions for the integration user |
| <a name="output_integration_guid"></a> [integration\_guid](#output\_integration\_guid) | Unique identifier for the integration used in by Lacework |
| <a name="output_policy_ocid"></a> [policy\_ocid](#output\_policy\_ocid) | OCID of the policy created to manage permissions for the integration user |
| <a name="output_user_ocid"></a> [user\_ocid](#output\_user\_ocid) | OCID of the user created for the Lacework integration |

