# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.




#########################
## Policies
#########################
output "policies" {
  description = "The returned resource attributes for Policies."
  value = {
    for x in oci_identity_policy.policies : x.name => { name = x.name,
      ETag                                                   = x.ETag,
      compartment_id                                         = x.compartment_id,
      defined_tags                                           = x.defined_tags,
      description                                            = x.description,
      freeform_tags                                          = x.freeform_tags,
      id                                                     = x.id,
      lastUpdateETag                                         = x.lastUpdateETag,
      policyHash                                             = x.policyHash,
      state                                                  = x.state,
      statements                                             = x.statements,
      time_created                                           = x.time_created,
      version_date                                           = x.version_date
    }
  }
}
