# -----------------------------------------------------------------------------
# Resources: Amazon Simple Queue Service
# -----------------------------------------------------------------------------

resource "aws_sqs_queue" "generate_email_queue" {
  name = "${var.namespace}-${var.stage}-generate-email-queue"
}

resource "aws_sqs_queue" "deliver_email_queue" {
  name = "${var.namespace}-${var.stage}-deliver-email-queue"
}
