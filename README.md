# Terraform Demo Static Website

This repository contains [Terraform](https://www.terraform.io/) modules and [Terragrunt](https://terragrunt.gruntwork.io/) live configuration
for deploying the Demo Static Website to AWS in 2 ways:
- AWS S3
- AWS Amplify

## Contents

- `./infrastructure-live` - "live" configuration for Terragrunt. Navigate there to deploy Demo Static Website across multiple environments.
- `./modules` - common directry for infrastructure modules. These modules are used in "live" configuration mentioned above.

## Credits

While preparing this demo configuration, the following modules were used as a reference:
- https://github.com/masterpointio/terraform-aws-amplify-app
- https://github.com/infrable-io/terraform-aws-static-website

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->