#Create an IAM Policy
resource "aws_iam_policy" "project_ec2_s3_policy" {
  name        = "${var.project_ec2_role_name}-policy"
  description = "Provides permission to access source code from S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*", "s3:GetObject",
                "s3:List*",
                "s3:PutObject",
                "s3-object-lambda:Get*",
                "s3-object-lambda:List*"
            ],
            "Resource": ["${var.s3_bucket_arn}",
                "${var.s3_bucket_arn}/*",
                "${var.s3_bucket_arn}/source/",
                "${var.s3_bucket_arn}/source/*",
                "${var.s3_bucket_arn}/source/static/*",
                "${var.s3_bucket_arn}/source/templates/*"
            ]
        }
    ]
  })
}

#Create an IAM Role
resource "aws_iam_role" "project_ec2_role" {
  name = "${var.project_ec2_role_name}"
  path = "/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

#Attach IAM Policy to ROle
resource "aws_iam_policy_attachment" "project_ec2_role_attach" {
  name       = "${var.project_ec2_role_name}-attach"
  roles      = [aws_iam_role.project_ec2_role.name]
  policy_arn = aws_iam_policy.project_ec2_s3_policy.arn
}

#Create an instance profile
resource "aws_iam_instance_profile" "project_ec2_profile" {
  name = aws_iam_role.project_ec2_role.name
  role = aws_iam_role.project_ec2_role.name
}