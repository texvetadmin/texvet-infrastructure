# -----------------------------------------------------------------------------
# Data: IAM
# -----------------------------------------------------------------------------

# data.template_file.cognito_iam_assume_role_policy.rendered
data "template_file" "cognito_iam_assume_role_policy" {
  template = "${
    file("${path.module}/iam/policies/assume-role/cognito-identity.json")
  }"

  vars {
    cognito_identity_pool_id = "${aws_cognito_identity_pool._.id}"
  }
}

# -----------------------------------------------------------------------------

# data.template_file.lambda_iam_policy.rendered
data "template_file" "lambda_iam_policy" {
  template = "${file("${path.module}/iam/policies/lambda.json")}"

  vars {
    cognito_user_pool_arn = "${aws_cognito_user_pool._.arn}"
  }
}

# -----------------------------------------------------------------------------
# Resources: IAM
# -----------------------------------------------------------------------------

# aws_iam_role.cognito
resource "aws_iam_role" "cognito" {
  name = "${var.namespace}-${var.stage}-identity"

  assume_role_policy = "${
    data.template_file.cognito_iam_assume_role_policy.rendered
  }"
}

# -----------------------------------------------------------------------------

# aws_iam_role.lambda
resource "aws_iam_role" "lambda" {
  name = "${var.namespace}-${var.stage}-identity-lambda"

  assume_role_policy = "${
    file("${path.module}/iam/policies/assume-role/lambda.json")
  }"
}

# aws_iam_policy.lambda
resource "aws_iam_policy" "lambda" {
  name = "${var.namespace}-${var.stage}-identity-lambda"

  policy = "${data.template_file.lambda_iam_policy.rendered}"
}

# aws_iam_policy_attachment.lambda
resource "aws_iam_policy_attachment" "lambda" {
  name = "${var.namespace}-${var.stage}-identity-lambda"

  policy_arn = "${aws_iam_policy.lambda.arn}"
  roles      = ["${aws_iam_role.lambda.name}"]
}

# -----------------------------------------------------------------------------
# Resource: Cognito
# -----------------------------------------------------------------------------

# https://www.terraform.io/docs/providers/aws/r/cognito_user_pool.html
# aws_cognito_user_pool._
resource "aws_cognito_user_pool" "_" {
  name = "${var.namespace}_${var.stage}"

  alias_attributes = [
    "email",
    "preferred_username",
  ]

  auto_verified_attributes = ["email"]

  sms_verification_message = "${var.cognito_signup_sms}"

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject = "${var.cognito_signup_email_subject}"
    email_message = "${var.cognito_signup_email_body}"
  }

  email_configuration {
    reply_to_email_address = "${var.cognito_email_replyto}"
  }

  password_policy {
    minimum_length    = 8
    require_uppercase = true
    require_lowercase = true
    require_numbers   = true
    require_symbols   = false
  }

  schema {
    name                = "email"
    attribute_data_type = "String"
    mutable             = true
    required            = true
  }

  schema {
    name                = "postalCode"
    attribute_data_type = "String"
    mutable             = true
    required            = false
  }

  lambda_config {
    pre_token_generation = "${aws_lambda_function._.arn}"
  }

  lifecycle {
    ignore_changes = ["schema"]
  }
}

# aws_cognito_user_pool_client._
resource "aws_cognito_user_pool_client" "_" {
  name = "${var.namespace}_${var.stage}_ui"

  user_pool_id    = "${aws_cognito_user_pool._.id}"
  generate_secret = false

  explicit_auth_flows = [
    "ADMIN_NO_SRP_AUTH",
    "USER_PASSWORD_AUTH",
  ]

  supported_identity_providers = [
    "COGNITO"
  ]
}

# aws_cognito_identity_pool._
resource "aws_cognito_identity_pool" "_" {
  identity_pool_name      = "${var.cognito_identity_pool_name}"
  developer_provider_name = "${var.cognito_identity_pool_provider}"

  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id     = "${aws_cognito_user_pool_client._.id}"
    provider_name = "cognito-idp.${var.region}.amazonaws.com/${aws_cognito_user_pool._.id}"
    server_side_token_check = false
  }

}

# aws_cognito_identity_pool_roles_attachment._
resource "aws_cognito_identity_pool_roles_attachment" "_" {
  identity_pool_id = "${aws_cognito_identity_pool._.id}"

  roles {
    "authenticated" = "${aws_iam_role.cognito.arn}"
  }
}

# -----------------------------------------------------------------------------
# Resources: Lambda
# -----------------------------------------------------------------------------

# aws_lambda_function._
resource "aws_lambda_function" "_" {
  function_name = "${var.namespace}-${var.stage}-identity-triggerhandlers"
  role          = "${aws_iam_role.lambda.arn}"
  runtime       = "nodejs8.10"
  filename      = "${path.module}/lambda/dist.zip"
  handler       = "index.handler"
  timeout       = 10
  memory_size   = 128

  source_code_hash = "${
    base64sha256(file("${path.module}/lambda/dist.zip"))
  }"
}

# aws_lambda_permission._
resource "aws_lambda_permission" "_" {
  principal     = "cognito-idp.amazonaws.com"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function._.arn}"
  source_arn    = "${aws_cognito_user_pool._.arn}"
}
