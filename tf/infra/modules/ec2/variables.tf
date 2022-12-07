variable "project_prefix" {
    type        = string
    description = "Prefix name for all resources created."
}

variable "aws_project_tags" {
    type        = map(object({
        tag_key = string
        tag_value = string
    }))
    description = "AWS resource tags for grouping projects. Associate desired key with tag_key and value with tag_value."
}

variable "ami_info" {
    type        = map
    description = "Specify name and owner."
}

variable "lt_info" {
    type = map
    description = "Specify instance_type, name, key (ssh key), and instance_profile_name."
}

variable "s3_bucket_info" {
    type        = map
    description = "Specify bucket name and key of object."
}

variable "vpc_id" {
    type        = string
    description = "Specify VPC of created security groups."
}

variable "public_subnets" {
    type        = list(string)
    description = "List of public subnet ids"
}

variable "private_subnets" {
    type        = list(string)
    description = "List of private subnet ids"
}

variable "asg_info"{
    type = map
}

variable "alb_target"{
    type = string
}