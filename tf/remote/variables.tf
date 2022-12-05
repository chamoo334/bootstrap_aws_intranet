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