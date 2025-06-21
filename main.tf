terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0"
    }
  }
}

provider "aws" {
  # Configuration options
 region = "eu-north-1"
}

resource "aws_instance" "mytestserver2" {
  ami = "ami-0989038dff76173d3"
  instance_type = "t3.micro"

  tags = {
    Name = "mytestserver2"
  }
}

  