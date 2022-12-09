# Spot instance request via terraform does not have an option to disable public ip & dns
# resource "aws_spot_instance_request" "private_spots" {
#     count = length(var.private_subnets)
#     ami = data.aws_ami.al2.id
#     instance_type = var.lt_info["instance_type"]
#     key_name = var.lt_info["key"]
#     security_groups       = ["${aws_security_group.private_sg.id}"]
#     wait_for_fulfillment  = "true"
#     # spot_type             = "persistent"
#     spot_type             = "one-time"
#     instance_interruption_behavior  = "terminate"
#     user_data_replace_on_change = true
#     subnet_id =  element(var.private_subnets, count.index) #"${var.public_subnets[0].id}"
#     # subnet_id =  "${aws_subnet.private_subnets[count.index].id}"

#     tags = {
#         "${var.aws_project_tags.name_tag.tag_key}" = "${var.aws_project_tags.name_tag.tag_value}"
#         "${var.aws_project_tags.purpose_tag.tag_key}" = "${var.aws_project_tags.purpose_tag.tag_value}"
#         "Name" = "${var.project_prefix}-priv-${count.index+1}"
#     }

# }

# resource "null_resource" "private_ec2_cli" {
#     provisioner "local-exec" {
#         command = <<EOF
#         aws ec2 run-instances --image-id ${data.aws_ami.al2.id} /
#         --count 1 --instance-type ${var.lt_info["instance_type"]} /
#         --key-name ${var.lt_info["key"]}  --security-group-ids ${aws_security_group.public_sg.id} /
#         --subnet-id ${var.private_subnets[0].id} --associate-public-ip-address /
#         --instance-market-options MarketType='spot'
#         EOF
#     }
# }