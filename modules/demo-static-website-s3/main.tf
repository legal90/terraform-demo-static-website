/**
 * # Terraform Module - AWS S3 Demo Static Website
 *
 * A Demo Terraform module for deploying a static website to AWS S3.
 */

# -----------------------------------------------------------------------------
# S3 BUCKET
# -----------------------------------------------------------------------------
resource "aws_s3_bucket" "this" {
  bucket = var.base_name
  tags   = var.tags
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}


# -----------------------------------------------------------------------------
# UPLOAD SITE CONTENT TO S3 BUCKET
# -----------------------------------------------------------------------------

resource "aws_s3_object" "dist" {
  for_each = fileset("${path.module}/website", "*.html")

  bucket = aws_s3_bucket.this.id
  key    = each.value
  source = "${path.module}/website/${each.value}"
  etag   = filemd5("${path.module}/website/${each.value}")
  acl = "public-read"
  content_type = "text/html"

  tags = var.tags
}

# -----------------------------------------------------------------------------
# CLOUDFRONT DISTRIBUTION
# Creates a distributed content delivery network using Amazon CloudFront.
# -----------------------------------------------------------------------------
resource "aws_cloudfront_distribution" "this" {
  default_root_object = "index.html"
  enabled             = true
  http_version        = "http2"
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  tags                = var.tags

  custom_error_response {
    error_caching_min_ttl = 60
    error_code            = 404
    response_code         = 404
    response_page_path    = "/404.html"
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    forwarded_values {
      cookies {
        forward = "none"
      }
      query_string = true
    }
    target_origin_id       = var.base_name
    viewer_protocol_policy = "redirect-to-https"
  }

  origin {
    domain_name = aws_s3_bucket.this.website_endpoint
    origin_id   = var.base_name

    custom_origin_config {
      http_port  = 80
      https_port = 443
      # Note: Amazon S3 does not support HTTPS connections when configured as a
      # website endpoint. You must specify HTTP Only as the Origin Protocol
      # Policy.
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
