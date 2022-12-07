# ALB target group
resource "aws_lb_target_group" "alb_tg" {
    name = "${var.project_prefix}-alb-tg"
    target_type        = "instance"
    port               = 80
    protocol           = "HTTP"
    vpc_id             = var.vpc_id
    load_balancing_algorithm_type = "round_robin" #"least_outstanding_requests"

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 10
        interval = 20
        port = 80
    }

    lifecycle {
        create_before_destroy = true
    }
}

# Create ALB
resource "aws_lb" "alb" {
    name            = "${var.project_prefix}-alb"
    security_groups = ["${aws_security_group.alb_sg.id}"]
    subnets         = var.public_subnets
    enable_cross_zone_load_balancing = true
    internal           = false
    load_balancer_type = "application"
}

#Attach target group
#Must run separately
resource "aws_lb_target_group_attachment" "alb_tg_attachment" {
    target_group_arn = aws_lb_target_group.alb_tg.arn
    target_id        = aws_lb.alb.arn
    port             = 80
    depends_on = [aws_lb_target_group.alb_tg]
}

#Create Listener for HTTP(80)
resource "aws_lb_listener" "lb_listener_http" {
    load_balancer_arn    = aws_lb.alb.id
    port                 = "80"
    protocol             = "HTTP"
    default_action {
        target_group_arn = aws_lb_target_group.alb_tg.id
        type             = "forward"
    }
}
