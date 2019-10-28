resource "aws_iam_role_policy" "read_table" {
  count = var.can_read_table ? 1 : 0

  name = "read_table"
  role = "${var.iam_role_id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ReadWriteTable",
      "Effect": "Allow",
      "Action": [
        "dynamodb:BatchGetItem",
        "dynamodb:GetItem",
        "dynamodb:Query",
        "dynamodb:Scan"
      ],
      "Resource": "arn:aws:dynamodb:*:*:table/${var.table_name}"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "write_table" {
  count = var.can_write_table ? 1 : 0

  name = "write_table"
  role = "${var.iam_role_id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ReadWriteTable",
      "Effect": "Allow",
      "Action": [
        "dynamodb:BatchWriteItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem"
      ],
      "Resource": "arn:aws:dynamodb:*:*:table/${var.table_name}"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "read_table_stream" {
  count = var.can_read_table_stream ? 1 : 0

  name = "read_table_stream"
  role = "${var.iam_role_id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "GetStreamRecords",
      "Effect": "Allow",
      "Action": "dynamodb:GetRecords",
      "Resource": "arn:aws:dynamodb:*:*:table/${var.table_name}/stream/* "
    }
  ]
}
EOF
}
