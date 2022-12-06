# Create public subnets. Number is dependent  on length of cidrs["public"]
resource "aws_subnet" "public_subnets" {
    count = length(var.cidrs["public"])
    vpc_id = aws_vpc.vpc.id
    cidr_block = element(var.cidrs["public"], count.index)
    availability_zone = element(var.subnet_azs["public"], count.index)
    map_public_ip_on_launch = true

    tags = {
        "${var.aws_project_tags.name_tag.tag_key}" = "${var.aws_project_tags.name_tag.tag_value}"
        "${var.aws_project_tags.purpose_tag.tag_key}" = "${var.aws_project_tags.purpose_tag.tag_value}"
        "Name" = "${var.project_prefix}-public-${count.index+1}"
    }

    depends_on = [aws_vpc.vpc]
}

# Create private subnets. Number is dependent  on length of cidrs["private"]
resource "aws_subnet" "private_subnets" {
    count = length(var.cidrs["private"])
    vpc_id = aws_vpc.vpc.id
    cidr_block = element(var.cidrs["private"], count.index)
    availability_zone = element(var.subnet_azs["private"], count.index)

    tags = {
        "${var.aws_project_tags.name_tag.tag_key}" = "${var.aws_project_tags.name_tag.tag_value}"
        "${var.aws_project_tags.purpose_tag.tag_key}" = "${var.aws_project_tags.purpose_tag.tag_value}"
        "Name" = "${var.project_prefix}-private-${count.index+1}"
    }

    depends_on = [aws_vpc.vpc]
}