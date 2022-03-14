# Terragrunt Live Config - Demo Static Website

This directory contains the configuration of so called "live" infrastructure for the Demo Static Website.
It is supposed to be used with [Terragrunt](https://github.com/gruntwork-io/terragrunt) tool in order to deploy the static website
across two environments (`dev`, `prod`) and different AWS accounts.

For background information, check out the [Keep your Terraform code DRY](https://terragrunt.gruntwork.io/docs/features/keep-your-terraform-code-dry/)
section of the Terragrunt documentation.


## How to deploy it using this configuration?

### Pre-requisites

1. Install [Terraform](https://www.terraform.io/) version `1.0.0` or newer and
   [Terragrunt](https://github.com/gruntwork-io/terragrunt) version `v0.36.0` or newer.
2. Update the `profile` in `dev/environment.hcl` and `prod/environment.hcl` with corresponging AWS profile names,
   which you have configured in your `~/.aws/config` or `~/.aws/credentials`.


### Deploying a single component

1. `cd` into the component folder (for example, `cd ./prod/demo-static-website-s3`).
2. Run `terragrunt apply` and, if the plan looks good, confirm applying these changes.


### Deploying all components in a certain environment

1. `cd` into the desired installation's folder (e.g. `cd ./prod/`).
2. Run `terragrunt run-all plan` to see all the changes you're about to apply.
3. If the plan looks good, run `terragrunt run-all apply` and all changes will be applied automatically.
