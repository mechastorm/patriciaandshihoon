resource "aws_route53_record" "site" {
   name = "${local.domain}"
   zone_id = "${data.aws_route53_zone.site.zone_id}"
   type = "A"
   alias {
     name    = "${aws_cloudfront_distribution.site.domain_name}"
     zone_id = "${aws_cloudfront_distribution.site.hosted_zone_id}"
     evaluate_target_health = false
   }
}

resource "aws_route53_record" "site_www" {
   name = "www.${local.domain}"
   zone_id = "${data.aws_route53_zone.site.zone_id}"
   type = "A"
   alias {
     name    = "${aws_cloudfront_distribution.site.domain_name}"
     zone_id = "${aws_cloudfront_distribution.site.hosted_zone_id}"
     evaluate_target_health = false
   }
}
