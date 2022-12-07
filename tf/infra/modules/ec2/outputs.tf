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

output "launch_template" {
    value = {
        "name" = aws_launch_template.project_launch_template.name
        "id" = aws_launch_template.project_launch_template.id
    }
}

output "alb" {
    value = {
        "name" = aws_lb.alb.name
        "id" = aws_lb.alb.id
        "dns" = aws_lb.alb.dns_name
        "target_group" ={
            "name" = aws_lb_target_group.alb_tg.name
            "id" = aws_lb_target_group.alb_tg.id
        }
    }
}