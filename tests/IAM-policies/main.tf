# Copyright (c) 2019 Oracle and/or its affiliates,  All rights reserved.


locals {
  policies_config = {
    default_compartment_id = var.compartment_id
    default_defined_tags   = null
    default_freeform_tags  = null
    policies = {
      policy_1 = {
        description    = "Test Policy 1"
        statements     = ["Allow group Administrators to manage virtual-network-family in tenancy"]
        version_date   = null
        compartment_id = null
        defined_tags   = {}
        freeform_tags  = null
      }
      policy_2 = {
        description    = "Test Policy 2"
        statements     = ["Allow service PSM to use subnets in tenancy"]
        version_date   = null
        compartment_id = null
        defined_tags   = {}
        freeform_tags  = {}
      }
    }
  }
}

module "oci_iam_policies" {

  source = "../../"

  providers = {
    oci.oci_home = "oci.home"
  }
  policies_config = local.policies_config


}

