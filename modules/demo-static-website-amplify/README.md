<!-- BEGIN_TF_DOCS -->
# Terraform Module - AWS Amplify Demo Static Website

A Demo Terraform module for deploying a static website to AWS Amplify.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_amplify_app.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_app) | resource |
| [aws_amplify_branch.master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_branch) | resource |
| [aws_amplify_webhook.master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_webhook) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token"></a> [access\_token](#input\_access\_token) | The personal GitHub access token for an Amplify app. | `string` | n/a | yes |
| <a name="input_base_name"></a> [base\_name](#input\_base\_name) | The base name used for Amplify app and related resources. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all created resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_site_url"></a> [site\_url](#output\_site\_url) | The URL which could be used to access the published website |
<!-- END_TF_DOCS -->