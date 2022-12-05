output "iam_role_profile" {
    value = {
        role = module.ec2_iam_role.ec2_role
        profile = module.ec2_iam_role.instance_profile
    }
}

# output "" {
#     value = {}
# }