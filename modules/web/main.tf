# -----------------------------------------------------------------------------
# Resources: Route53
# -----------------------------------------------------------------------------

data "aws_route53_zone" "_" {
  name = "barter.io."
}