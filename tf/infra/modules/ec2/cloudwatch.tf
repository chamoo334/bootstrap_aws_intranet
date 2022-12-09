# # Autoscaling Group Scale up cloudwatch alarm
# resource "aws_cloudwatch_metric_alarm" "scale_up" {
#     alarm_name = "${var.project_prefix}-cpu-up-alarm"
#     comparison_operator = "GreaterThanOrEqualToThreshold"
#     evaluation_periods = "2"
#     metric_name = "CPUUtilization"
#     namespace = "AWS/EC2"
#     period = "60"
#     statistic = "Average"
#     threshold = "15"
#     alarm_actions = [
#         "${aws_autoscaling_policy.scale_up_policy.arn}"
#     ]
#     dimensions = {
#         AutoScalingGroupName = "${aws_autoscaling_group.asg.name}"
#     }  
# }


# Autoscaling Group Scale down cloudwatch alarm
# resource "aws_cloudwatch_metric_alarm" "scale_down" {
#     alarm_name = "${var.project_prefix}-cpu-down-alarm"
#     comparison_operator = "GreaterThanOrEqualToThreshold"
#     evaluation_periods = "2"
#     metric_name = "CPUUtilization"
#     namespace = "AWS/EC2"
#     period = "60"
#     statistic = "Average"
#     threshold = "10"
#     alarm_actions = [
#         "${aws_autoscaling_policy.scale_down_policy.arn}"
#     ]
#     dimensions = {
#         AutoScalingGroupName = "${aws_autoscaling_group.asg.name}"
#     }  
# }



# Autoscaling Group Scale down cloudwatch alarm
# resource "aws_cloudwatch_metric_alarm" "custom_metric" {}
