# # # Create dashboard
# resource "aws_cloudwatch_dashboard" "main" {
#   dashboard_name = "${var.project_prefix}-dashboard"

#   dashboard_body = <<EOF
# {
#   "widgets": [
#     {
#       "type": "metric",
#       "x": 0,
#       "y": 0,
#       "width": 12,
#       "height": 6,
#       "properties": {
#         "metrics": [
#           [
#             "AWS/EC2",
#             "CPUUtilization",
#             "InstanceId",
#             "i-012345"
#           ]
#         ],
#         "period": 300,
#         "stat": "Average",
#         "region": "us-east-1",
#         "title": "EC2 Instance CPU"
#       }
#     },
#     {
#       "type": "text",
#       "x": 0,
#       "y": 7,
#       "width": 3,
#       "height": 3,
#       "properties": {
#         "markdown": "Hello world"
#       }
#     }
#   ]
# }
# EOF
# }

# Autoscaling Group Scale up cloudwatch alarm
resource "aws_cloudwatch_metric_alarm" "scale_up" {
    alarm_name = "${var.project_prefix}-cpu-up-alarm"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = "10"
    alarm_actions = [
        "${aws_autoscaling_policy.scale_up_policy.arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.asg.name}"
    }  
}


# Autoscaling Group Scale down cloudwatch alarm
resource "aws_cloudwatch_metric_alarm" "scale_down" {
    alarm_name = "${var.project_prefix}-cpu-down-alarm"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = "10"
    alarm_actions = [
        "${aws_autoscaling_policy.scale_down_policy.arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.asg.name}"
    }  
}



# Autoscaling Group Scale down cloudwatch alarm
# resource "aws_cloudwatch_metric_alarm" "scale_down" {}
