# Create role for ec2 instances
module "ec2_iam_role" {
  source                 = "./modules/iam"
  project_ec2_role_name  = "${var.project_prefix}-ec2-role"
  s3_bucket_arn  = "${var.s3_bucket_arn}"
}

# Create VPC with public and private subnet count based on length of var.cidrs["public"]
# and var.cidrs["private"]. # CIDRS must equal # subnet_azs
module "vpc" {
  source = "./modules/complete_vpc"
  aws_project_tags = var.aws_project_tags
  project_prefix = var.project_prefix
  cidrs = var.cidrs
  subnet_azs = var.subnet_azs
  ssh_key = var.ssh_key
}

# Create Autoscaling Group along with, sg, launch template,
module "ec2" {
  source = "./modules/ec2"
  project_prefix = var.project_prefix
  aws_project_tags = var.aws_project_tags
  ami_info = var.ami_info
  lt_info = {
    "name" = "${var.project_prefix}-lt"
    "instance_type" = var.lt_info["instance_type"]
    "key" = var.ssh_key
    "instance_profile_name" = module.ec2_iam_role.ec2_role.name
  }
  s3_bucket_info = var.s3_bucket_info
  vpc_id  = module.vpc.vpc_info.id
  public_subnets = module.vpc.vpc_info.subnets.public.ids
  private_subnets = module.vpc.vpc_info.subnets.public.ids
  asg_info = var.asg_info
  alb_target = var.alb_target
}