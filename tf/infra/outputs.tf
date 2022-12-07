output "iam_role_profile" {
    value = {
        role = module.ec2_iam_role.ec2_role
        profile = module.ec2_iam_role.instance_profile
    }
}

output "vpc_data" {
    value = module.vpc.vpc_info
}

output "security_groups" {
    value = module.ec2.security_groups
}

output "launch_template" {
    value = module.ec2.launch_template
}

output "alb" {
    value = module.ec2.alb
}