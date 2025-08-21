terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.9.0"
    }
  }
}

locals {
  website_files = ["index.html", "error.html"]
}
# CREATING S3 BUCKET 
resource "aws_s3_bucket" "practice" {
  bucket        = "tusharsharmaq101"
  force_destroy = true
  tags = {
    "Name"        = "Website_bucket"
    "Environmnet" = "Development"
  }
}

# ALLOWING PUBLIC ACCESS BY DISABLING ALL OF THE OPTION
resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket                  = aws_s3_bucket.practice.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# CREATE S3 BUCKET POLICY TO ALLOW EVERYONE TO READ THIS PARTICULAR S3
resource "aws_s3_bucket_policy" "practice_policy" {
  bucket = aws_s3_bucket.practice.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowPublicRead",
        Effect    = "Allow",
        Principal = "*",
        Action    = ["s3:GetObject"],
        Resource  = "${aws_s3_bucket.practice.arn}/*"
      }
    ]
  })
  depends_on = [aws_s3_bucket_public_access_block.s3_public_access]
}

# ENABLED VERSIONING OF S3
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.practice.id
  versioning_configuration {
    status = "Enabled"
  }
}

# configuring the s3 as a website
resource "aws_s3_bucket_website_configuration" "my_website" {
  bucket = aws_s3_bucket.practice.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

# CREATING THE S3 OBJECT AND UPLOADING WEBSITE FILES
resource "aws_s3_object" "website_files" {
  for_each               = toset(local.website_files)
  bucket                 = aws_s3_bucket.practice.id
  key                    = each.value
  source                 = "${path.module}/${each.value}"
  etag                   = filemd5("${path.module}/${each.value}")
  server_side_encryption = "AES256"
  content_type = "text/html"

}

output "url" {
  value       = aws_s3_bucket_website_configuration.my_website.website_endpoint
  description = "URL Of the website"
}
