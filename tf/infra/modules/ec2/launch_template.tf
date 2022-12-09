# Create launch template user data 
data "template_file" "lt_user_data" {
  template = <<EOF
Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
cloud_final_modules:
- [scripts-user, always]

--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"

#!/bin/bash
sudo su
yum update -y
sudo amazon-linux-extras install epel -y
yum install httpd mod_wsgi stress -y
systemctl enable httpd
systemctl start httpd
#aws s3 cp s3://cmoore-gen-bucket/source /home/ec2-user/test_cp --recursive
aws s3 cp "s3://${var.s3_bucket_info["name"]}/${var.s3_bucket_info["key"]}" /var/www/html/index.html
export instance_id=$(curl http://169.254.169.254/latest/meta-data/instance-id)
export avail_zone=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
sed -i "s/_instanceID_/$instance_id/" /var/www/html/index.html
sed -i "s/_AZ_/$avail_zone/" /var/www/html/index.html
--//--
EOF
}

# Create launch template
resource "aws_launch_template" "project_launch_template" {
    name = "${var.project_prefix}-lt"
    image_id = data.aws_ami.al2.id
    instance_type = var.lt_info["instance_type"]
    key_name = var.lt_info["key"]

    instance_market_options {
        market_type = "spot"
    }

    monitoring {
        enabled = true
    }

    network_interfaces {
        associate_public_ip_address = true
        security_groups = [aws_security_group.public_sg.id]
    }

    iam_instance_profile {
      name = var.lt_info["instance_profile_name"]
    }

    lifecycle {
      create_before_destroy = true
    }

    tag_specifications {
      resource_type = "instance"
      tags = {
          "${var.aws_project_tags.name_tag.tag_key}" = "${var.aws_project_tags.name_tag.tag_value}"
          "${var.aws_project_tags.purpose_tag.tag_key}" = "${var.aws_project_tags.purpose_tag.tag_value}"
      }
    }

    user_data = base64encode(data.template_file.lt_user_data.rendered)
}