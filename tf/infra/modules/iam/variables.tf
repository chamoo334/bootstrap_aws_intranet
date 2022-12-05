variable "project_ec2_role_name" {
    type        = string
    description = "Name of role for EC2 instances to assume"
}

variable "s3_bucket_arn" {
    type        = string
    description = "ARN of associated s3 bucket"
}