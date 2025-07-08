terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0"
    }
   
  }
}


provider "aws" {
  # Configuration options
  region = "us-east-1"
}



resource "aws_instance" "static_website_instance" {
  ami           = "ami-05fcfb9614772f051" # Example AMI ID for Amazon Linux 2
  instance_type = "t2.micro"

  tags = {
    "Name" = "StaticWebsiteInstance"
  }
}
resource "aws_s3_bucket" "static_website_bucket" {
  bucket = "mystaticbucket-staticwb128725"
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.static_website_bucket.bucket
  source = "./index.html"
  key    = "index.html"
}


resource "aws_s3_object" "style_css" {
  bucket = aws_s3_bucket.static_website_bucket.bucket
  source = "./style.css"
  key    = "style.css"
}