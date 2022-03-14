output "site_url" {
  description = "The URL which could be used to access the published website"
  value       = "https://prod.${aws_amplify_app.this.default_domain}/"
}
