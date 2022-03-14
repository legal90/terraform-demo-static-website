# Set common variables for the environment. This is automatically pulled in in the root terragrunt.hcl configuration to
# feed forward to the child modules.
locals {
  environment = "prod"
  region      = "us-east-2"
  profile     = "_REPLACE_WITH_YOUR_PROD_AWS_PROFILE_" # AWS Profile has to be configured in your `~/.aws/config` and/or `~/.aws/credentials`

  # Parameters of S3 bucket for using as terraform backend for storing the state.
  # TODO: replace it with your AWS S3 bucket name and region. Terragrunt will create the bucket if it doesn't exist.
  tf_state_s3_bucket        = "_REPLACE_ME_"
  tf_state_s3_bucket_region = "us-east-1"
}
