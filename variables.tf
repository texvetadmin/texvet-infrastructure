# -----------------------------------------------------------------------------
# Variables: General
# -----------------------------------------------------------------------------

# var.namespace
variable "namespace" {
  description = "AWS resource namespace/prefix"
}

# var.region
variable "region" {
  description = "AWS region"
}

# var.stage
variable "stage" {
  description = "Environment stage such as dev, demo, staging, production"
}

# -----------------------------------------------------------------------------
# Variables: Cognito
# -----------------------------------------------------------------------------

# var.cognito_identity_pool_name
variable "cognito_identity_pool_name" {
  description = "Cognito identity pool name"
}

# var.cognito_identity_pool_provider
variable "cognito_identity_pool_provider" {
  description = "Cognito identity pool provider"
}

# var.cognito_signup_email_subject
variable "cognito_signup_email_subject" {
  description = "The email subject to send when signing up"
}

# var.cognito_signup_email_body
variable "cognito_signup_email_body" {
  description = "The email body to send when signing up"
}

# var.cognito_signup_sms
variable "cognito_signup_sms" {
  description = "The sms message to send when signing up"
}

# var.cognito_email_replyto
variable "cognito_email_replyto" {
  description = "The reply to email address for the signup emails"
}

# -----------------------------------------------------------------------------
# Variables: Cloudfront
# -----------------------------------------------------------------------------

# var.tls_cert_arn
variable "tls_cert_arn" {
  description = "The ARN of the TLS/SSL certification manually provisioned and approved"
}
