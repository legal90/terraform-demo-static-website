# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "base_name" {
  type        = string
  description = "The base name used for all created resources: S3 bucket, CloudFront distribution, etc."

  validation {
    condition     = can(regex("[a-z0-9\\.-]+", var.base_name))
    error_message = "The base name must contain only lowercase letters, numbers, periods (.), and dashes (-) (i.e. it must be a valid DNS name)."
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "tags" {
  description = "A map of tags to add to all created resources."
  type        = map(string)
  default     = {}
}
