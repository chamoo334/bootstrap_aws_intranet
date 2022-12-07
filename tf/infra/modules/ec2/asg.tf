# resource "aws_autoscaling_group" "asg" {
#     name = "${var.project_prefix}-asg"
#     force_delete              = true
#     termination_policies      = ["OldestInstance"]
    
#     #sizes
#     max_size                  = var.asg_info["max"]
#     min_size                  = var.asg_info["min"]
#     desired_capacity          = var.asg_info["desired"]
#     health_check_grace_period = var.asg_info["health_check_period"]
#     health_check_type         = var.asg_info["health_check_type"]
#     load_balancers = ["${aws_lb.alb.id}"]
#     enabled_metrics = [
#         "GroupMinSize",
#         "GroupMaxSize",
#         "GroupDesiredCapacity",
#         "GroupInServiceInstances",
#         "GroupTotalInstances"
#     ]
#     metrics_granularity = "1Minute"
#     vpc_zone_identifier  = var.public_subnets

#     launch_template {
#         id      = aws_launch_template.project_launch_template.id
#         version = "${aws_launch_template.project_launch_template.latest_version}" #ensures update triggers refresh
#     }

#     #refresh when configuration altered. 50% of instances will stay active
#     #automatically triggered by a change to launch template
#     instance_refresh {
#         strategy = "Rolling"
#         preferences {
#             min_healthy_percentage = 50
#         }
#         triggers = ["tag"]
#     }
#     # Required to redeploy without an outage.
#     lifecycle {
#         create_before_destroy = true
#     }

#     #ec2 tags
#     tag {
#         key                 = "${var.aws_project_tags.name_tag.tag_key}"
#         value               = "${var.aws_project_tags.name_tag.tag_value}"
#         propagate_at_launch = true
#     }
#     tag {
#         key                 = "${var.aws_project_tags.purpose_tag.tag_key}"
#         value               = "${var.aws_project_tags.purpose_tag.tag_value}"
#         propagate_at_launch = true
#     }

#     depends_on =[aws_lb.alb]
# }

# Scale up
# resource "aws_autoscaling_policy" "asg_up" {
#   name = "${var.project_prefix}_policy_up"
#   scaling_adjustment = 1
#   adjustment_type = "ChangeInCapacity"
#   cooldown = 300
#   autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
# }

# # Scale down
# resource "aws_autoscaling_policy" "asg_down" {
#   name = "${var.project_prefix}_policy_down"
#   scaling_adjustment = 1
#   adjustment_type = "ChangeInCapacity"
#   cooldown = 300
#   autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
# }

# tf apply -target=module.ec2.aws_autoscaling_group.asg --auto-approve