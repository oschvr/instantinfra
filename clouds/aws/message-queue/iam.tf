resource "aws_iam_role" "r" {
  name = "${var.prefix}-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "p" {
  name = "${var.prefix}-iam-policy"
  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "kafka-cluster:*"
        ],
        Resource : [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "iam_rpa" {
  role       = aws_iam_role.r.name
  policy_arn = aws_iam_policy.p.arn
}

resource "aws_iam_instance_profile" "ip" {
  name = "${var.prefix}-instance-profile"
  role = aws_iam_role.r.name
}