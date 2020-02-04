# Oracle Cloud Infrastructure (OCI) IAM Policies Module for Terraform

## Introduction


This module assist in provisioning OCI Policies and adding statements to those policies.
  

## Solution

The module covers the following usecases:

* Creating one or multiple policies and adding statements to those policies.

## Prerequisites
This module does not create any dependencies or prerequisites. 

Create the following before using this module: 
  * Required IAM construct to allow for the creation of resources

## Getting Started

A fully-functional example is provided in the `examples` directory.  

The following scenarios are covered in the examples:
* Creating a collection of Policies, each Policy containing a list of statements.
 

## Accessing the Solution
This core service module is typically used at deployment, with no further access required.

## Module inputs

### Provider

This module supports a custom provider. With a custom provider, IAM resources must be deployed in your home tenancy, which might be different from the region that will contain other deployments. 

You'll be managing those providers in the tf automation projects where you reference this module.

Example:


```
provider "oci" {
  tenancy_ocid     = "${var.tenancy_id}"
  user_ocid        = "${var.user_id}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  region           = "${var.region}"
}

provider "oci" {
  alias            = "home"
  tenancy_ocid     = "${var.tenancy_id}"
  user_ocid        = "${var.user_id}"
  fingerprint      = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  region           = [for i in data.oci_identity_region_subscriptions.this.region_subscriptions : i.region_name if i.is_home_region == true][0]
}

data "oci_identity_region_subscriptions" "this" {
  tenancy_id = var.tenancy_id
}
```

The following IAM attributes are available in the the `terraform.tfvars` file:

```
### PRIMARY TENANCY DETAILS

# Get this from the bottom of the OCI screen (after logging in, after Tenancy ID: heading)
primary_tenancy_id="<tenancy OCID"
# Get this from OCI > Identity > Users (for your user account)
primary_user_id="<user OCID>"

# the fingerprint can be gathered from your user account (OCI > Identity > Users > click your username > API Keys fingerprint (select it, copy it and paste it below))
primary_fingerprint="<PEM key fingerprint>"
# this is the full path on your local system to the private key used for the API key pair
primary_private_key_path="<path to the private key that matches the fingerprint above>"

# region (us-phoenix-1, ca-toronto-1, etc)
primary_region="<your region>"

### DR TENANCY DETAILS

# Get this from the bottom of the OCI screen (after logging in, after Tenancy ID: heading)
dr_tenancy_id="<tenancy OCID"
# Get this from OCI > Identity > Users (for your user account)
dr_user_id="<user OCID>"

# the fingerprint can be gathered from your user account (OCI > Identity > Users > click your username > API Keys fingerprint (select it, copy it and paste it below))
dr_fingerprint="<PEM key fingerprint>"
# this is the full path on your local system to the private key used for the API key pair
dr_private_key_path="<path to the private key that matches the fingerprint above>"

# region (us-phoenix-1, ca-toronto-1, etc)
dr_region="<your region>"
```



### Policies

Policies are presented as a map containing a collection of policies. Each policy specifies the  attributes for a policy, including a list of statements.


**`oci_identity_policy.policies`**


| Attribute | Data Type | Required | Default Value | Valid Values | Description |
|---|---|---|---|---|---|
| provider | string | yes | "oci.oci_home"| string containing the name of the provider as defined by the automation that consumes this module | See the examples section in order to understand how to set the provider|
| count | number | yes | 0 | the number of resources to be created | the number of resources to be created |
| name | string | yes | "OCI-Policy" | string of the display name | Resource name |
| compartment\_id | string | yes | none | string of the compartment OCID | This is the OCID of the compartment |
| statements | list(string) | yes | none | a list of strings containing the policy statements | a list of strings containing the policy statements |
| description | string | no | N/A (no default) | The provided description |
| define\_tags | map(string) | no | N/A (no default) | The defined tags.
| freeform\_tags| map(string) | no | N/A (no default) | The freeform\_tags.
| version\_date| string | no | Current date | The version of the policy.

**Example**
The following example will create 2 policies, each policy containing a list of statements

```
# Policies config

policies_config = {
  default_compartment_id = "<default_compartment_ocid>"
  default_defined_tags           = "<default_defined_tags>"
  default_freeform_tags          = "<default_freeform_tags>"
  policies = {
    policy_1 = {
      description = "Test Policy 1"
      statements = ["<statement-1>", "<statement-2>"] 
      version_date = null
      compartment_id = "<specific_compartment_ocid>"
      defined_tags   = "<specific_defined_tags>"
      freeform_tags  = "<specific_freeform_tags>"
    }
    policy_2 = {
      description  = "Test Policy 2"
      statements = ["<statement-1>"]
      version_date = null
      compartment_id = "<specific_compartment_ocid>"
      defined_tags   = "<specific_defined_tags>"
      freeform_tags  = "<default_freeform_tags>"
    }
  }
}

```

## Outputs

This module is returning 1 map object:
* `Policies` : Contains the details about each provisioned Policy.

## Notes/Issues


## URLs

For Oracle Cloud Infrastructure IAM Dynamic Policies documentation, see https://docs.cloud.oracle.com/iaas/Content/Identity/Concepts/policies.htm

## Versions

This module has been developed and tested by running terraform on Oracle Linux Server release 7.7 

```
user-linux$ terraform --version
Terraform v0.12.19
+ provider.oci v3.58.0

```

## Contributing

This project is open source. Oracle appreciates any contributions that are made by the open source community.

## License

Copyright (c) 2020, Oracle and/or its affiliates.

Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

See [LICENSE](LICENSE) for more details.
