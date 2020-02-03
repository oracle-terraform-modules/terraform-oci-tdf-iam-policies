# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


locals {

  #################
  # Policy
  #################
  # default values

  default_policy = {
    tenancy_compartment_id = null
    description            = "OCI Policy created with the OCI Core IAM Policies Module"
    statements             = []
    name                   = "OCI-Policy"
    defined_tags           = {}
    freeform_tags          = { "Department" = "Security" }
    version_date           = formatdate("YYYY-MM-DD", timestamp())
  }
}

resource "oci_identity_policy" "policies" {
  provider = "oci.oci_home"
  for_each = var.policies_config != null ? (var.policies_config.policies != null ? var.policies_config.policies : {}) : {}
  #Required
  compartment_id = each.value.compartment_id != null ? each.value.compartment_id : (var.policies_config.default_compartment_id != null ? var.policies_config.default_compartment_id : local.default_policy.compartment_id)
  description    = each.value.description != null ? each.value.description : local.default_policy.description
  name           = each.key
  statements     = each.value.statements

  #Optional
  defined_tags  = each.value.defined_tags != null ? each.value.defined_tags : (var.policies_config.default_defined_tags != null ? var.policies_config.default_defined_tags : local.default_policy.defined_tags)
  freeform_tags = each.value.freeform_tags != null ? each.value.freeform_tags : (var.policies_config.default_freeform_tags != null ? var.policies_config.default_freeform_tags : local.default_policy.freeform_tags)
  version_date  = each.value.version_date != null ? each.value.version_date : local.default_policy.version_date
}




