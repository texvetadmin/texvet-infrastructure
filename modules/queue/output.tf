# -----------------------------------------------------------------------------
# Outputs: Amazon Simple Queue Service
# -----------------------------------------------------------------------------
output "generate_email_queue_id" {
  value       = ["${aws_sqs_queue.generate_email_queue.*.id}"]
  description = "The URL for the created Amazon SQS queue."
}

output "generate_email_queue_arn" {
  value       = ["${aws_sqs_queue.generate_email_queue.*.arn}"]
  description = "The Amazon Resource Name (ARN) specifying the role."
}

output "deliver_email_id" {
  value       = ["${aws_sqs_queue.deliver_email_queue.*.id}"]
  description = "The URL for the created Amazon SQS queue."
}

output "deliver_email_arn" {
  value       = ["${aws_sqs_queue.deliver_email_queue.*.arn}"]
  description = "The Amazon Resource Name (ARN) specifying the role."
}
