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