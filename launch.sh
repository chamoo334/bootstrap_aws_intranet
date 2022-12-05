#!/bin/bash

echo "<h1>Hello World From launch.sh" > /home/ec2-user/test.html

instance_profile=`curl http://169.254.169.254/latest/meta-data/iam/security-credentials/`
aws_access_key_id=`curl http://169.254.169.254/latest/meta-data/iam/security-credentials/${instance_profile} | grep AccessKeyId | cut -d':' -f2 | sed 's/[^0-9A-Z]*//g'`
aws_secret_access_key=`curl http://169.254.169.254/latest/meta-data/iam/security-credentials/${instance_profile} | grep SecretAccessKey | cut -d':' -f2 | sed 's/[^0-9A-Za-z/+=]*//g'`
token=`curl -s http://169.254.169.254/latest/meta-data/iam/security-credentials/${instance_profile} | sed -n '/Token/{p;}' | cut -f4 -d'"'`

file="index"
bucket="cmoore-proj1-bucket"
out_file="/home/ec2-user/test.html"
s3_region="us-east-1"
date="`date +'%a, %d %b %Y %H:%M:%S %z'`"
resource="/${bucket}/${file}"
signature_string="GET\n\n\n${date}\nx-amz-security-token:${token}\n/${resource}"
signature=`/bin/echo -en "${signature_string}" | openssl sha1 -hmac ${aws_secret_access_key} -binary | base64`
authorization="AWS ${aws_access_key_id}:${signature}"

curl -s -H "Date: ${date}" -H "X-AMZ-Security-Token: ${token}" -H "Authorization: ${authorization}" "https://s3-${s3_region}.amazonaws.com/${resource}" -o "${out_file}"