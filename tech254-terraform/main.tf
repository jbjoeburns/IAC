# who is the cloud provider
provider "aws" {

# location of AWS
	region = var.aws-region
}
# ^ Run these commands to download required dependencies!

resource "aws_vpc" "tech254-joe-iac-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "tech254-joe-iac-vpc"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.tech254-joe-iac-vpc.id
  cidr_block = var.private_subnet_cidr
  map_public_ip_on_launch = false
  availability_zone = var.private_subnet_az

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.tech254-joe-iac-vpc.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = var.public_subnet_az

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "tech254-joe-iac-ig" {
  vpc_id = aws_vpc.tech254-joe-iac-vpc.id
}

resource "aws_route_table" "tech254-joe-iac-pubrt" {
  vpc_id = aws_vpc.tech254-joe-iac-vpc.id
    
  route {
    cidr_block = var.pubrt_cidr
    gateway_id = aws_internet_gateway.tech254-joe-iac-ig.id
    }
}

resource "aws_route_table_association" "tech254-joe-iac-pubrt-assoc"{
    subnet_id = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.tech254-joe-iac-pubrt.id
}

resource "aws_security_group" "tech254-joe-iac-db-sg" {
    vpc_id = aws_vpc.tech254-joe-iac-vpc.id
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }    
    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

	egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }    
    
    ingress {
        from_port = 27017
        to_port = 27017
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "tech254-joe-iac-app-sg" {
    vpc_id = aws_vpc.tech254-joe-iac-vpc.id
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }    
    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

	egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }    
    
    ingress {
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

		egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }    
    
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# create service on the cloud (EC2) on AWS
resource "aws_instance" "tech254-joe-iac-db-test" {
	ami = var.db-ami_id
	instance_type = var.web-app_instance_type
	subnet_id = aws_subnet.private-subnet.id
	vpc_security_group_ids = [aws_security_group.tech254-joe-iac-db-sg.id]
	tags = {
		Name = "tech254-joe-iac-db-test"
	}
}

# create service on the cloud (EC2) on AWS
resource "aws_instance" "tech254-joe-iac-app-test" {
	ami = var.app-ami_id
	instance_type = var.web-app_instance_type
	subnet_id = aws_subnet.public-subnet.id
	vpc_security_group_ids = [aws_security_group.tech254-joe-iac-app-sg.id]

	user_data = file("provision.sh")

	tags = {
		Name = "tech254-joe-iac-app-test"
	}
}