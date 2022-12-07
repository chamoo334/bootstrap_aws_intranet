# resource "aws_spot_instance_request" "public_spot" {
#     name = "${var.project_prefix}-lt"
#     image_id = data.aws_ami.al2.id
#     instance_type = var.lt_info["instance_type"]
#     key_name = var.lt_info["key"]
#     security_groups       = ["${aws_security_group.public_sg.id}"]
#     wait_for_fulfillment  = "true"
#     spot_type             = "persistent"
#     # spot_type             = "one-time"
#     instance_interruption_behavior  = "terminate"
#     user_data_replace_on_change = true
#     subnet_id = "${var.public_subnets[0].id}"

#     tags = {
#         Name = "${var.NAME_PREFIX[var.CURRENT_ENV]}-public-ec2"
#         name = "${var.NAME_PREFIX[var.CURRENT_ENV]}-public-ec2"
#         first-name = "chantel"
#     }

# }

# resource "null_resource" "create_ec2_via_cli" {
#     provisioner "local-exec" {
#         command = "aws ec2 run-instances --image-id ${data.aws_ami.al2.id} \
#         --count 1 --instance-type ${var.lt_info["instance_type"]} \
#         --key-name ${var.lt_info["key"]}  --security-group-ids ${aws_security_group.public_sg.id} 
#         --subnet-id ${var.public_subnets[0].id} --associate-public-ip-address 
#         --instance-market-options MarketType='spot'"
#     }
# }