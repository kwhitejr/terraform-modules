resource "aws_iam_role_policy" "publish_sns" {
  count = var.can_publish_sns ? 1 : 0

  name = "publish_sns"
  role = "${var.iam_role_id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublishSns",
      "Effect": "Allow",
      "Action": [
        "sns:Publish"
      ],
      "Resource": "${local.sns_topic_arn}"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "subscribe_sns" {
  count = var.can_subscribe_sns ? 1 : 0

  name = "subscribe_sns"
  role = "${var.iam_role_id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "SubscribeSns",
      "Effect": "Allow",
      "Action": [
        "sns:Subscribe"
      ],
      "Resource": "${local.sns_topic_arn}"
    }
  ]
}
EOF
}
