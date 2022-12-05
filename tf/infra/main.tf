#create role for ec2 instances
module "ec2_iam_role" {
  source                 = "./modules/iam"
  project_ec2_role_name  = "${var.project_prefix}-ec2-role"
  s3_bucket_arn  = "${var.s3_bucket_arn}"
}