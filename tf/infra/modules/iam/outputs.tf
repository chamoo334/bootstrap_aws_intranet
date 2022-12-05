output "ec2_role"{
  value = {
    name = aws_iam_role.project_ec2_role.name
    role_arn = aws_iam_role.project_ec2_role.arn
  }
}

output "instance_profile"{
  value = {
    name = aws_iam_instance_profile.project_ec2_profile.name
    profile_arn = aws_iam_instance_profile.project_ec2_profile.arn
  }
}