# who is the cloud provider
provider "aws" {

# location of AWS
	region = var.aws-region
}
# ^ Run these commands to download required dependencies!


# create service on the cloud (EC2) on AWS
resource "aws_instance" "tech254-joe-iac-test" {
	ami = var.web-app_ami_id
	instance_type = var.web-app_instance_type
	tags = {
		Name = var.web-app_instance_tag
	}
}
