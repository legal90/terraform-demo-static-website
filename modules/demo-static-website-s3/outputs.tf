output "site_url" {
  description = "The URL which could be used to access the published website"
  value       = "https://${aws_cloudfront_distribution.this.domain_name}/"
}
