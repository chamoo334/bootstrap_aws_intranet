data "aws_ami" "al2" {
    most_recent = true
    filter {
        name = "name"
        values = [var.ami_info["name"]]
    }
    owners = [var.ami_info["owner"]]
}