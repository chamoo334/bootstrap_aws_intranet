# Bootstrap AWS Intranet

## Requirements
- Terraform CLI
- AWS CLI & access keys
- Amazon S3 Bucket to store the web page source code.

## Goal
[vpc image]()
Everything you need to recreate the above is found within this repo. There are a couple of things you'll need to:
1. Add the `source` directory to your bucket.
2. Add the required variables in `tf/infra/example.tfvar`.
3. Create the resources using Terraform CLI
   1. Hint: Order matters.
4. Follow the additional instructions on the website once your VPC and autoscaling group are up.

## General Project Structure
Main directory is `bootstrap_aws_intranet/tf/infra
```
BOOTSTRAP_AWS_INTRANET.
|   .gitignore
|   README.md
|-- source/
|    |   images/
|    |   index.thml
|-- tf/
|    |   infra/
|          |   example.tfvars
|          |   main.tf
|          |   outputs.tf
|          |   providers.tf
|          |   variables.tf
|          |   modules/
|                 |   complete_vpc/
|                 |   ec2/
|                 |   iam/
|    |   remote/
```
