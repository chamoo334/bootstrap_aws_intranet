data "aws_caller_identity" "current" {}

locals {
    root_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
}

#Create S3 bucket
resource "aws_s3_bucket" "project_backend" {
    bucket = var.bucket_name
}

#Create S3 bucket policy
data "aws_iam_policy_document" "project_bucket_access" {
    statement {
        sid = "DenyAllBucketAccess"
        principals {
            type        = "AWS"
            identifiers = ["*"]
        }
        effect = "Deny"
        actions = ["s3:Get*",
                "s3:List*"]
        resources = [
            aws_s3_bucket.project_backend.arn,
            "${aws_s3_bucket.project_backend.arn}/*",
        ]
        condition {
            test = "ForAllValues:ArnNotLike"
            variable = "aws:PrincipalArn"
            values = ["${local.root_arn}", "${data.aws_caller_identity.current.arn}"]
            #values = ["${local.root_arn}", "${data.aws_caller_identity.current.arn}", "${aws_iam_role.project_ec2_role.arn}"]
        }
    }

    statement {
        sid = "DenyAllReadTerraform"
        principals {
            type        = "AWS"
            identifiers = ["*"]
        }
        effect = "Deny"
        actions = ["s3:Get*",
                "s3:List*"]
        resources = [
            "${aws_s3_bucket.project_backend.arn}/terraform",
            "${aws_s3_bucket.project_backend.arn}/terraform/*",
        ]
        condition {
            test = "ForAllValues:ArnNotLike"
            variable = "aws:PrincipalArn"
            values = ["${local.root_arn}", "${data.aws_caller_identity.current.arn}"]
        }
    }

    statement {
        sid = "DenyAllWriteTerraform"
        principals {
            type        = "AWS"
            identifiers = ["*"]
        }
        effect = "Deny"
        actions = ["s3:Put*"]
        resources = [
            "${aws_s3_bucket.project_backend.arn}/terraform",
            "${aws_s3_bucket.project_backend.arn}/terraform/*"
        ]
        condition {
            test = "ForAllValues:ArnNotLike"
            variable = "aws:PrincipalArn"
            values = ["${data.aws_caller_identity.current.arn}"]
        }
    }

    statement {
        sid = "DenyAllDelete"
        principals {
            type        = "AWS"
            identifiers = ["*"]
        }
        effect = "Deny"
        actions = ["s3:Delete*"]
        resources = [
            aws_s3_bucket.project_backend.arn,
            "${aws_s3_bucket.project_backend.arn}/*",
        ]
        condition {
            test = "ForAllValues:ArnNotLike"
            variable = "aws:PrincipalArn"
            values = ["${local.root_arn}", "${data.aws_caller_identity.current.arn}"]
        }
    }
}

#Attach policy to bucket
resource "aws_s3_bucket_policy" "project_bucket_policy" {
  bucket = aws_s3_bucket.project_backend.id
  policy = data.aws_iam_policy_document.project_bucket_access.json
}

#Set bucket acl
resource "aws_s3_bucket_acl" "project_backend" {
  bucket = aws_s3_bucket.project_backend.id
  acl    = "private"
}

#Enable versioning in bucket
resource "aws_s3_bucket_versioning" "versioning_project_backend" {
  bucket = aws_s3_bucket.project_backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

#Create separate directories for terraform statefiles and source code 
resource "aws_s3_object" "terraform_dir_object" {
    depends_on = [aws_s3_bucket_versioning.versioning_project_backend]
    bucket = aws_s3_bucket.project_backend.id
    key    = "terraform/"
    acl    = "private"
    content_type = "application/x-directory"
}

resource "aws_s3_object" "source_dir_object" {
    depends_on = [aws_s3_bucket_versioning.versioning_project_backend]
    bucket = aws_s3_bucket.project_backend.id
    key    = "source/"
    acl    = "private"
    content_type = "application/x-directory"
}