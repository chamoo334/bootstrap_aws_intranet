# Create role for ec2 instances
module "ec2_iam_role" {
  source                 = "./modules/iam"
  project_ec2_role_name  = "${var.project_prefix}-ec2-role"
  s3_bucket_arn  = "${var.s3_bucket_arn}"
}

# Create VPC with 2 public and 1 private subnet
module "vpc" {
  source = "./modules/complete_vpc"
  aws_project_tags = var.aws_project_tags
  project_prefix = var.project_prefix
  cidrs = var.cidrs
  subnet_azs = var.subnet_azs
  ssh_key = var.ssh_key
}