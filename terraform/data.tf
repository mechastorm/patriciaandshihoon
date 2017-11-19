data "aws_route53_zone" "site" {
  name = "${local.domain}."
}

data "aws_acm_certificate" "site" {
  provider = "aws.east"
  domain   = "${local.domain}"
  statuses = ["ISSUED"]
}
