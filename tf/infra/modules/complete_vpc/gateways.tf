# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  depends_on = [aws_vpc.vpc]

  tags = {
        "${var.aws_project_tags.name_tag.tag_key}" = "${var.aws_project_tags.name_tag.tag_value}"
        "${var.aws_project_tags.purpose_tag.tag_key}" = "${var.aws_project_tags.purpose_tag.tag_value}"
        "Name" = "${var.project_prefix}-igw"
    }
}

# Elastic-IP (eip) for NAT
resource "aws_eip" "nat_eip" {
  count      = length(var.cidrs["private"])
  vpc        = true

  tags = {
        "${var.aws_project_tags.name_tag.tag_key}" = "${var.aws_project_tags.name_tag.tag_value}"
        "${var.aws_project_tags.purpose_tag.tag_key}" = "${var.aws_project_tags.purpose_tag.tag_value}"
        "Name" = "${var.project_prefix}-eip-${count.index+1}"
  }

  depends_on = [aws_internet_gateway.igw]
}

# Create NAT Gateway for private subnet #TODO: update for dynamic creation based on
resource "aws_nat_gateway" "ngw" {
  count         = length(var.cidrs["private"])
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.public_subnets.*.id, count.index)


#   allocation_id = aws_eip.nat_eip[count.index].id
#   subnet_id     = aws_subnet.public_subnets[count.index].id
  # default public connectivity

  tags = {
        "${var.aws_project_tags.name_tag.tag_key}" = "${var.aws_project_tags.name_tag.tag_value}"
        "${var.aws_project_tags.purpose_tag.tag_key}" = "${var.aws_project_tags.purpose_tag.tag_value}"
        "Name" = "${var.project_prefix}-nat-${count.index+1}"
  }

  # To ensure proper ordering, it is recommended to add an
  # explicit dependency on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}