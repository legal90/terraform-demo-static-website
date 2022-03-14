# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "base_name" {
  description = "The base name used for Amplify app and related resources."
  type        = string
}

variable "access_token" {
  description = "The personal GitHub access token for an Amplify app."
  type        = string
  sensitive   = true
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
