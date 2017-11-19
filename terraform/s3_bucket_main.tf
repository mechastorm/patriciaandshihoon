resource "aws_s3_bucket" "site" {
  bucket = "${local.domain}"
  acl    = "public-read"
  policy = <<EOF
{
"Id": "bucket_policy_site",
"Version": "2012-10-17",
"Statement": [
  {
    "Sid": "bucket_policy_site_main",
    "Action": [
      "s3:GetObject"
    ],
    "Effect": "Allow",
    "Resource": "arn:aws:s3:::${local.domain}/*",
    "Principal": "*"
  }
]
}
EOF

  website {
      index_document = "index.html"
      error_document = "404.html"
  }

  tags {
    project = "${local.domain}"
  }

  force_destroy = true
}
