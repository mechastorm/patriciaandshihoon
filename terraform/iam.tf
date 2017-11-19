resource "aws_iam_user" "travis" {
  name = "travis-${local.domain}"
  path = "/system/"
}

data "aws_iam_policy_document" "travis-s3-push" {
  statement {
    sid = "AllowGroupToSeeBucketListInTheConsole"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation"
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }

  statement {
    sid = "PushDataToS3Bucket"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion"
    ]

    resources = [
      "arn:aws:s3:::${local.domain}",
      "arn:aws:s3:::${local.domain}/",
      "arn:aws:s3:::${local.domain}/*"
    ]
  }
}

resource "aws_iam_user_policy" "travis-s3-push" {
  name = "s3-push"
  user = "${aws_iam_user.travis.name}"

  policy = "${data.aws_iam_policy_document.travis-s3-push.json}"
}
