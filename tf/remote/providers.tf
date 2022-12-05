terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 4.41.0"
        }
    }

    required_version = "~> 1.3.4"
}

# Update default tags in accordance var.aws_project_tags
provider "aws" {
    region = var.aws_region
    default_tags {
        tags = {
            "${var.aws_project_tags.name_tag.tag_key}" = "${var.aws_project_tags.name_tag.tag_value}"
            "${var.aws_project_tags.purpose_tag.tag_key}" = "${var.aws_project_tags.purpose_tag.tag_value}"
        }
    }
}