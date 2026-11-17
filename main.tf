# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.92"
#     }
#   }

# }

# provider "aws" {
#     region = "ap-south-1"

# }


resource "aws_key_pair" "mykey" {
  key_name   = "Webserver"
  public_key = file("aws-key.pub")

}

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "defaultsg" {
  name        = "auto_sg"
  description = "this is degault sg"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "open SSh"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP Open"
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "flask open"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all access"
  }

  tags = {
    Name = "auto_sg"
  }

}


resource "aws_instance" "my_instace" {
  #count = 2 #meta arugment
  # for_each = tomap({
  #     server1 = "t2.micro"
  #     server2 = "t2.medium"
  # })
  # depends_on = [ aws_default_vpc.default, aws_key_pair.mykey ]
  key_name        = aws_key_pair.mykey.key_name
  security_groups = [aws_security_group.defaultsg.name]
  ami             = var.ec2_ami
  instance_type   = var.ec2_instance_type
  # instance_type = each.value
  user_data = file("install_nginx.sh")

  root_block_device {
    volume_size = var.env == "prod" ? 20 : var.ec2_default_root_block_device
    volume_type = "gp3"
  }

  tags = {
    #   Name = each.key
    Name = "Webserver"
  }

}