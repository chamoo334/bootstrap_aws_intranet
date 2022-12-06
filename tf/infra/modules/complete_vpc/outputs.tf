output "vpc_info" {
    value = {
        "id" = aws_vpc.vpc.id
        "subnets" = {
            "public" = {
                "ids" = aws_subnet.public_subnets[*].id
                "rt" = aws_route_table.public_subnet_route_tables[*].id
            }
            "private" = {
                "ids" = aws_subnet.private_subnets[*].id
                "rt" = aws_route_table.private_subnet_route_tables[*].id
            }
        }
        "igw" = aws_internet_gateway.igw.id
        "ngw" = aws_nat_gateway.ngw[*].id
    }
}