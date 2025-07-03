terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0"
    }
    # The random provider is used to generate random values, such as passwords or unique identifiers
    # It is often used in conjunction with other resources to ensure that certain attributes are unique or
    # randomly generated.
    # For example, you might use the random provider to generate a random password for an AWS
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}


provider "aws" {
  # Configuration options
 region = var.region
 
}


resource "aws_instance" "mytestserver1" {
  # The aws_instance resource is used to create an EC2 instance in AWS.
  # It allows you to specify various attributes such as the AMI ID, instance type,
  ami           = var.ami_linux
  instance_type = var.instance_type_micro

  tags = {
    Name = "mytestserver1"
  }
}

resource "aws_instance" "mytestserver2" {
  ami           = var.ami_windows
  instance_type = var.instance_type_nano

  tags = {
    Name = "mytestserver2"
  }
}


