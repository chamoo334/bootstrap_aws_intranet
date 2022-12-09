aws_region = "us-east-1"
aws_project_tags = {
    "name_tag" = {
        tag_key = "name"
        tag_value = "your-name"
    }
    "purpose_tag" = {
        tag_key = "purpose"
        tag_value = "project-name"
    }
}
project_prefix = "resource-prefix"
s3_bucket_arn = "arn:aws:s3:::your-bucket"
cidrs = { vpc = ["10.0.0.0/16"]
          public = ["10.0.1.0/24", "10.0.2.0/24"]
          private = ["10.0.3.0/24", "10.0.4.0/24"]}
subnet_azs = { public = ["us-east-1a", "us-east-1b"]
              private = ["us-east-1a", "us-east-1b"]}
ssh_key = "key-name"
ami_info = {
    "name" = "amzn2-ami-kernel-5.10-hvm-2.0.20221103.3-x86_64-gp2"
    "owner" = "amazon"
}
lt_info = {
    "instance_type" = "t3.micro"
}
s3_bucket_info = {
    "name" = "bucket-name"
    "key" = "key/index.html"
}
asg_info = {
    "max" = 4
    "min" = 2
    "desired" = 2
    "health_check_type" =  "ELB" #"EC2"
    "health_check_period" = 30
    "cpu_up_target_value" = 50.0
    "cpu_down_target_value" = 20.0
}
alb_target = "i-........."