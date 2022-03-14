/**
 * # Terraform Module - AWS Amplify Demo Static Website
 *
 * A Demo Terraform module for deploying a static website to AWS Amplify.
 */

resource "aws_amplify_app" "this" {
  name                     = var.base_name
  description              = "Demo Static Website"
  repository               = "https://github.com/legal90/static-site-demo"
  access_token             = var.access_token
  enable_branch_auto_build = true

  tags = var.tags
}

resource "aws_amplify_branch" "master" {
  app_id       = aws_amplify_app.this.id
  branch_name  = "master"
  display_name = "prod"
  stage        = "PRODUCTION"

  tags = var.tags
}

resource "aws_amplify_webhook" "master" {
  app_id      = aws_amplify_app.this.id
  branch_name = aws_amplify_branch.master.branch_name

  # NOTE: We trigger the webhook via local-exec so as to kick off the first build on creation of Amplify App.
  provisioner "local-exec" {
    command = "curl -X POST -d {} '${aws_amplify_webhook.master.url}&operation=startbuild' -H 'Content-Type:application/json'"
  }
}
