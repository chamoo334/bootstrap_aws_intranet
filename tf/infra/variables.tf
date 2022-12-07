variable "aws_region" {
    type        = string
    description = "AWS Region to deploy resources."
}

variable "aws_project_tags" {
    type        = map(object({
        tag_key = string
        tag_value = string
    }))
    description = "AWS resource tags for grouping projects. Associate desired key with tag_key and value with tag_value."
}

variable "project_prefix" {
    type        = string
    description = "Prefix name for all resources created."
}

variable "s3_bucket_arn" {
    type        = string
    description = "ARN of associated s3 bucket"
}

variable "cidrs" {
    type = map(list(string))
    description = "Map a list of cidrs to vpc, public and private keys. "
}

variable "subnet_azs" {
    type = map(list(string))
    description = "Map a list of availability zones to both public and private keys. "
}

variable "ssh_key" {
    type = string
    description = "Key name without extension"
}

variable "ami_info" {
    type        = map
    description = "Specify name and owner."
}

variable "lt_info" {
    type = map
    description = "Specify instance_type."
}

variable "s3_bucket_info" {
    type        = map
    description = "Specify bucket name and key of object."
}

variable "asg_info"{
    type = map
}

variable "alb_target"{
    type = string
}