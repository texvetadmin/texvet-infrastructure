##################################################################################
# TERRAFORM STATE
##################################################################################
terraform {
  backend "s3" {
    bucket = "texvet-terraform"
    key    = "environment"
    region = "us-east-1"
  }
}

##################################################################################
# PROVIDERS
##################################################################################
provider "aws" {
  region = "${var.region}"
}

##################################################################################
# DATA
##################################################################################
# data.aws_caller_identity._
data "aws_caller_identity" "_" {}

##################################################################################
# MODULES
##################################################################################

# module.identity
module "identity" {
  source = "./modules/identity"

  namespace = "${var.namespace}"
  region    = "${var.region}"
  stage     = "${var.stage}"

  cognito_identity_pool_name     = "${var.cognito_identity_pool_name}"
  cognito_identity_pool_provider = "${var.cognito_identity_pool_provider}"
  cognito_signup_email_subject   = "${var.cognito_signup_email_subject}"
  cognito_signup_email_body      = "${var.cognito_signup_email_body}"
  cognito_signup_sms             = "${var.cognito_signup_sms}"
  cognito_email_replyto          = "${var.cognito_email_replyto}"
}