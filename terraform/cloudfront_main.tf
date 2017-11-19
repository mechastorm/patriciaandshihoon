resource "aws_cloudfront_origin_access_identity" "site" {
  comment = "${local.domain}.s3-website-${local.region}.amazonaws.com"
}

resource "aws_cloudfront_distribution" "site" {
  origin {
    domain_name = "${local.domain}.s3-website-${local.region}.amazonaws.com"
    // domain_name = "${aws_s3_bucket.site.bucket_domain_name}"
    origin_id   = "${local.domain}_bucket"

    // s3_origin_config {
    //   origin_access_identity = "origin-access-identity/cloudfront/${aws_cloudfront_origin_access_identity.site.id}"
    // }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${local.domain}"
  default_root_object = "index.html"

  // logging_config {
  //   include_cookies = false
  //   bucket          = "mylogs.s3.amazonaws.com"
  //   prefix          = "myprefix"
  // }

  aliases = ["${local.domain}", "www.${local.domain}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.domain}_bucket"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 3
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags {
    project = "${local.domain}"
  }

  viewer_certificate {
    ssl_support_method = "sni-only"
    acm_certificate_arn = "${data.aws_acm_certificate.site.arn}"
  }
}
