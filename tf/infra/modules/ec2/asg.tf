# Create autoscaling group
# Automatically includes the following tags: launch teamplate id, asg name, launchtemplate version
resource "aws_autoscaling_group" "asg" {
    name                    = "${var.project_prefix}-asg"
    vpc_zone_identifier     = var.public_subnets
    force_delete            = true
    termination_policies    = ["OldestInstance"] #"OldestLaunchTemplate"
    target_group_arns       = ["${aws_lb_target_group.alb_tg.arn}"]

    #sizes
    max_size           = var.asg_info["max"]
    min_size           = var.asg_info["min"]
    desired_capacity   = var.asg_info["desired"]

    #health checks
    health_check_type           = var.asg_info["health_check_type"]
    health_check_grace_period   = var.asg_info["health_check_period"]

    launch_template {
        id       = aws_launch_template.project_launch_template.id
        version  = "${aws_launch_template.project_launch_template.latest_version}"
    }

    # automatically triggered by change to launch_template
    instance_refresh {
        strategy = "Rolling"
        preferences {
            min_healthy_percentage = 50
        }
    }
}

#asg scale up policy
resource "aws_autoscaling_policy" "scale_up_policy" {
  name                   = "${var.project_prefix}-asg-up-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

#asg scale down policy
resource "aws_autoscaling_policy" "scale_down_policy" {
  name                   = "${var.project_prefix}-asg-down-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}