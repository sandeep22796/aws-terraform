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
  region = "eu-north-1"
}

# This Terraform configuration sets up a static website hosted on an S3 bucket
resource "aws_instance" "static_website_instance" {
  ami           = "ami-00c8ac9147e19828e" # Example AMI ID for Amazon Linux 2
  instance_type = "t3.micro"

  tags = {
    "Name" = "StaticWebsiteInstance"
  }
}


resource "aws_s3_bucket" "static_website_bucket" {
  bucket = "mystaticbucket-staticwb128725"
}

resource "aws_s3_bucket_public_access_block" "static_website_bucket_block" {
  bucket = aws_s3_bucket.static_website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "static_website_bucket_policy" {
  bucket = aws_s3_bucket.static_website_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.static_website_bucket.id}/*"
      }
    ]
  })
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