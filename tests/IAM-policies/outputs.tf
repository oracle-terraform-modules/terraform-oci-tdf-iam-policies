# Copyright (c) 2019 Oracle and/or its affiliates,  All rights reserved.


#########################
## Policies
#########################

output "policies_config" {
  description = "Policies:"
  value       = { policies = module.oci_iam_policies.policies, tenancy_home_region = [for i in data.oci_identity_region_subscriptions.this.region_subscriptions : i.region_name if i.is_home_region == true][0] }
}