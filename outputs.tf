# -----------------------------------------------------------------------------
# Providers
# -----------------------------------------------------------------------------

# output.aws_account_id
output "aws_account_id" {
  value = "${data.aws_caller_identity._.account_id}"
}

# output.aws_region
output "aws_region" {
  value = "${var.region}"
}

# output.stage
output "stage" {
  value = "${var.stage}"
}

# -----------------------------------------------------------------------------
# Outputs: Cognito
# -----------------------------------------------------------------------------

# output.cognito_user_pool_id
output "cognito_user_pool_id" {
  value = "${module.identity.cognito_user_pool_id}"
}

# output.cognito_user_pool_arn
output "cognito_user_pool_arn" {
  value = "${module.identity.cognito_user_pool_arn}"
}

# output.cognito_user_pool_client_id
output "cognito_user_pool_client_id" {
  value = "${module.identity.cognito_user_pool_client_id}"
}

# output.cognito_identity_pool_id
output "cognito_identity_pool_id" {
  value = "${module.identity.cognito_identity_pool_id}"
}

# output.cognito_identity_pool_name
output "cognito_identity_pool_name" {
  value = "${var.cognito_identity_pool_name}"
}

# output.cognito_identity_pool_provider
output "cognito_identity_pool_provider" {
  value = "${var.cognito_identity_pool_provider}"
}
