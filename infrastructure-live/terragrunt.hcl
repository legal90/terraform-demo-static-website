# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  # Extract the variables we need for easy access
  profile     = local.environment_vars.locals.profile
  region      = local.environment_vars.locals.region
  environment = local.environment_vars.locals.environment

  tf_state_s3_bucket        = local.environment_vars.locals.tf_state_s3_bucket
  tf_state_s3_bucket_region = local.environment_vars.locals.tf_state_s3_bucket_region

  # We assume that the name of the component will be the leaf directory basename: `demo-static-website-s3`, `demo-static-website-amplify`, etc.
  component = basename(get_terragrunt_dir())

  tags = {
    Environment = local.environment
    CreatedBy   = "terraform"
  }
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region  = "${local.region}"
  profile = "${local.profile}"
}
EOF
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    bucket         = local.tf_state_s3_bucket
    region         = local.tf_state_s3_bucket_region
    profile        = "${local.profile}"
    key            = "demo/${local.component}/${local.environment}/${local.region}/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit.
inputs = merge(
  {
    tags = local.tags
  },
  local.environment_vars.locals,
)
