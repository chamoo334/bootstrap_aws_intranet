# Create RT for public subnets
resource "aws_route_table" "public_subnet_route_tables" {
    count = length(var.cidrs["public"])
    vpc_id = aws_vpc.vpc.id

    tags = {
        "${var.aws_project_tags.name_tag.tag_key}" = "${var.aws_project_tags.name_tag.tag_value}"
        "${var.aws_project_tags.purpose_tag.tag_key}" = "${var.aws_project_tags.purpose_tag.tag_value}"
        "Name" = "${var.project_prefix}-rtpub-${count.index+1}"
    }

    depends_on = [aws_subnet.public_subnets]
}

# Add routes for public to IGW
resource "aws_route" "public_subnets_igw" {
    count                  = length(var.cidrs["public"])
    route_table_id         = element(aws_route_table.public_subnet_route_tables.*.id, count.index)
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.igw.id

    depends_on = [aws_internet_gateway.igw, aws_subnet.public_subnets]
}

# Association record for RT with public subnets
resource "aws_route_table_association" "public_route_associations" {
  count          = length(var.cidrs["public"])
  subnet_id     = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.public_subnet_route_tables.*.id, count.index)
}


# Create RT for private subnets
resource "aws_route_table" "private_subnet_route_tables" {
    count = length(var.cidrs["private"])
    vpc_id = aws_vpc.vpc.id

    tags = {
        "${var.aws_project_tags.name_tag.tag_key}" = "${var.aws_project_tags.name_tag.tag_value}"
        "${var.aws_project_tags.purpose_tag.tag_key}" = "${var.aws_project_tags.purpose_tag.tag_value}"
        "Name" = "${var.project_prefix}-rtpriv-${count.index+1}"
    }

    depends_on = [aws_subnet.private_subnets]
}


# Create route for private to NAT
resource "aws_route" "private_subnets_nat" {
    count                  = length(var.cidrs["private"])
    route_table_id         = element(aws_route_table.private_subnet_route_tables.*.id, count.index)
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = element(aws_nat_gateway.ngw.*.id, count.index)

    depends_on = [aws_nat_gateway.ngw, aws_subnet.private_subnets]
}

# Association record for RT with private subnets
resource "aws_route_table_association" "private_route_associations" {
  count          = length(var.cidrs["private"])
  subnet_id     = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private_subnet_route_tables.*.id, count.index)
}