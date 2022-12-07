output "security_groups" {
    value = {
        "public_subnet" = {
            "name" = aws_security_group.public_sg.name
            "id" = aws_security_group.public_sg.id
        }
        "private_subnet" = {
            "name" = aws_security_group.private_sg.name
            "id" = aws_security_group.private_sg.id
        }
        "elb" = {
            "name" = aws_security_group.alb_sg.name
            "id" = aws_security_group.alb_sg.id
        }
    }
}