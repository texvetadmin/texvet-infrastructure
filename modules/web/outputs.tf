# -----------------------------------------------------------------------------
# Outputs: Cloudfront
# -----------------------------------------------------------------------------

# aws_cloudfront_distribution._.domain_name
output "aws_cloudfront_distribution._.domain_name" {
  value = "${aws_cloudfront_distribution._.domain_name}"
}

# aws_cloudfront_distribution._.domain_name
output "aws_cloudfront_distribution.alias.domain_name" {
  value = "${aws_cloudfront_distribution.alias.*.domain_name}"
}

# aws_cloudfront_distribution.admin.domain_name
output "aws_cloudfront_distribution.admin.domain_name" {
  value = "${aws_cloudfront_distribution.admin.domain_name}"
}
