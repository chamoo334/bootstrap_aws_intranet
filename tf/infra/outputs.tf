output "iam_role_profile" {
    value = {
        role = module.ec2_iam_role.ec2_role
        profile = module.ec2_iam_role.instance_profile
    }
}

output "vpc_data" {
    value = module.vpc.vpc_info
}

# output "security_groups" {
#     value = {
#         general = module.ec2.ec2_gen_sg
#     }
# }

# output "" {
#     value = {}
# }