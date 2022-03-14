# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory before the double-slash, into a temporary folder, and execute your Terraform commands in that folder.
# Note: the double slash (//) here is intentional and required.
terraform {
  source = "${get_parent_terragrunt_dir()}/..//modules/demo-static-website-s3"
}

# Include all settings from the root terragrunt.hcl file
include "root" {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  base_name = "demo-static-website-s3"
}
