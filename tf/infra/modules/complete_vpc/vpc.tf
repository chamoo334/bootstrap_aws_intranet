# Create a single VPC
resource "aws_vpc" "vpc" {
    cidr_block = var.cidrs["vpc"][0]
    enable_dns_support = true #gives you an internal domain name
    enable_dns_hostnames = true #gives you an internal host name
    # enable_classiclink = false
    instance_tenancy = "default" # default is shared

    tags = {
        "${var.aws_project_tags.name_tag.tag_key}" = "${var.aws_project_tags.name_tag.tag_value}"
        "${var.aws_project_tags.purpose_tag.tag_key}" = "${var.aws_project_tags.purpose_tag.tag_value}"
        "Name" = "${var.project_prefix}-vpc"
    }
}

