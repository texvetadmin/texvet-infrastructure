# -----------------------------------------------------------------------------
# Variables: General
# -----------------------------------------------------------------------------

# var.region
variable "region" {
  description = "AWS region"
}

# -----------------------------------------------------------------------------
# Variables: Cloudfront
# -----------------------------------------------------------------------------

# var.tls_cert_arn
variable "tls_cert_arn" {
  description = "The ARN of the TLS/SSL certification manually provisioned and approved"
}
