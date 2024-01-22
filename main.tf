locals {
  policy_name = length(var.policy_name) > 0 ? var.policy_name : "${var.name_prefix}_policy_${random_id.uniq.hex}"
  user_name = length(var.user_name) > 0 ? var.user_name : "${var.name_prefix}_user_${random_id.uniq.hex}"
  group_name = length(var.group_name) > 0 ? var.group_name : "${var.name_prefix}_group_${random_id.uniq.hex}"
  version_file   = "${abspath(path.module)}/VERSION"
  module_name    = basename(abspath(path.module))
  module_version = fileexists(local.version_file) ? file(local.version_file) : ""
}

resource "random_id" "uniq" {
  byte_length = 4
}

module "lacework_oci_credentials" {
  source        = "lacework/iam-user/oci"
  version       = "~> 0.3"
  tenancy_id    = var.tenancy_id
  create        = var.create
  freeform_tags = var.freeform_tags
  email         = var.user_email
  name_prefix   = var.name_prefix
  user_name     = local.user_name
  group_name    = local.group_name
}

resource "oci_identity_policy" "lacework_policy" {
  count          = var.create ? 1 : 0
  compartment_id = var.tenancy_id
  description    = "Permission policy for the Lacework CSPM user"
  name           = local.policy_name
  freeform_tags  = var.freeform_tags
  statements = [
    # Keep alphabetical order to avoid duplicates
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect compartments in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect domains in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect groups in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect instance-images in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect internet-gateways in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect leaf-certificates in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect load-balancers in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect policies in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect route-tables in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect security-lists in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect subnets in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect tag-defaults in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect tenancies in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect vcns in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect vnic-attachments in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect vnics in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect volume-attachments in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to inspect volumes in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to read buckets in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to read compute-clusters in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to read instances in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to read network-security-groups in tenancy",
    "Allow group '${module.lacework_oci_credentials.group_name}' to read users in tenancy"
  ]
}

data "oci_identity_tenancy" "tenancy" {
  tenancy_id = var.tenancy_id
}

data "oci_identity_region_subscriptions" "home_region" {
  tenancy_id = var.tenancy_id
  filter {
    name   = "is_home_region"
    values = [true]
  }
}

# wait for X seconds for things to settle down on the OCI side
# before trying to create the Lacework external integration
resource "time_sleep" "wait_time" {
  create_duration = var.wait_time
  depends_on = [
    module.lacework_oci_credentials,
    oci_identity_policy.lacework_policy
  ]
}

resource "lacework_integration_oci_cfg" "lacework_integration" {
  count     = var.create ? 1 : 0
  name      = var.integration_name
  user_ocid = module.lacework_oci_credentials.user_ocid
  credentials {
    private_key = module.lacework_oci_credentials.user_private_key_pem
    fingerprint = module.lacework_oci_credentials.user_public_key_fingerprint
  }
  home_region = data.oci_identity_region_subscriptions.home_region.region_subscriptions[0].region_name
  tenant_id   = data.oci_identity_tenancy.tenancy.id
  tenant_name = data.oci_identity_tenancy.tenancy.name
  depends_on  = [time_sleep.wait_time]
}

data "lacework_metric_module" "lwmetrics" {
  name    = local.module_name
  version = local.module_version
}
