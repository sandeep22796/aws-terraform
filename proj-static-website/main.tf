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
  bucket = "mystaticbucket-staticwb128725" # Unique bucket name across all AWS accounts and region
}

resource "aws_s3_bucket_public_access_block" "static_website_bucket_block" { 
  # This resource blocks public access to the S3 bucket
  # It is important to block public access to prevent unauthorized access to the bucket
  bucket = aws_s3_bucket.static_website_bucket.id
  # The block_public_acls, block_public_policy, ignore_public_acls, and restrict_public_buckets
  # attributes are used to control public access to the bucket.
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "static_website_bucket_policy" {
  # This resource defines a bucket policy for the S3 bucket
  # The bucket policy allows public read access to the objects in the S3 bucket
  # The bucket policy is applied to the S3 bucket using the bucket attribute
  # The bucket attribute specifies the S3 bucket to which the policy applies
  bucket = aws_s3_bucket.static_website_bucket.id
  # This resource defines a bucket policy that allows public read access to the objects in the S3 bucket
  # The policy allows anyone to perform the s3:GetObject action on the objects in the
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.static_website_bucket.id}/*"
      }
      # This statement allows public read access to the objects in the S3 bucket
      # The Principal is set to "*" which means anyone can access the objects 
      # The Action is set to "s3:GetObject" which allows read access to the objects
      # The Resource is set to the ARN of the S3 bucket with a wildcard (*) at the end  
      # to allow access to all objects in the bucket.
    ]
  })
}


resource "aws_s3_object" "index_html" {
  # This resource uploads the index.html file to the S3 bucket
  # The index.html file is the main page of the static website
  bucket = aws_s3_bucket.static_website_bucket.bucket
  # The bucket attribute specifies the S3 bucket to which the object is uploaded
  # The source attribute specifies the local file path of the index.html file
  source = "./index.html"
  key    = "index.html"
}


resource "aws_s3_object" "style_css" {
  # This resource uploads the style.css file to the S3 bucket
  # The style.css file contains the styles for the static website
  bucket = aws_s3_bucket.static_website_bucket.bucket
  # The bucket attribute specifies the S3 bucket to which the object is uploaded
  # The source attribute specifies the local file path of the style.css file
  source = "./style.css"
  key    = "style.css"
}