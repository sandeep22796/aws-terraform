terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "6.0.0"
        }
    }
        backend "s3" {
            bucket         = "mybucketdemofe0efc95d074af56"
            key            = "remote_state_management.tfstate" # Path within the bucket
            region         = "eu-north-1" # Replace with your desired region
        }
    
}

provider "aws" {
  region = "eu-north-1"

}

resource "aws_instance" "remote-state" {
  ami = "ami-0c55b159cbfafe1f0" # Example AMI, replace with your desired AMI
  instance_type = "t3.nano" # Example instance type, replace with your desired type
  tags = {
    Name = "RemoteStateManagement"
  }  
}



