#Create security group for public ec2 instances
resource "aws_security_group" "public_sg" {
    name = "${var.project_prefix}-public-sg"
    description = "Terraform public ec2 security group"
    vpc_id = "${var.vpc_id}"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        "${var.aws_project_tags.name_tag.tag_key}" = "${var.aws_project_tags.name_tag.tag_value}"
        "${var.aws_project_tags.purpose_tag.tag_key}" = "${var.aws_project_tags.purpose_tag.tag_value}"
        "Name" = "${var.project_prefix}-public-sg"
    }
}

#Create security group for private ec2 instances to allow
#ssh and internal TCP connections
resource "aws_security_group" "private_sg" {
    name = "${var.project_prefix}-private-sg"
    description = "Terraform private ec2 security group"
    vpc_id = "${var.vpc_id}"

    # http connections
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        security_groups = ["${aws_security_group.public_sg.id}"]
    }

    # ping test
    ingress {
        from_port   = 8
        to_port     = 0
        protocol    = "icmp"
        security_groups = ["${aws_security_group.public_sg.id}"]
    }

    #SSH from anywhere 
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # lifecycle {
    #     # Necessary if changing 'name' or 'name_prefix' properties.
    #     create_before_destroy = true
    # }

    tags = {
        "${var.aws_project_tags.name_tag.tag_key}" = "${var.aws_project_tags.name_tag.tag_value}"
        "${var.aws_project_tags.purpose_tag.tag_key}" = "${var.aws_project_tags.purpose_tag.tag_value}"
        "Name" = "${var.project_prefix}-private-sg"
    }
}

#ELB Security group
resource "aws_security_group" "alb_sg" {
  name        = "${var.project_prefix}-alb-sg"
  description = "Terraform application load balancer security group"
  vpc_id      = "${var.vpc_id}"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
