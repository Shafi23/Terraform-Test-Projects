resource "aws_s3_bucket" "static_site" {
  bucket = "shafi-static-site-162591926474-784129" # MUST be globally unique

  tags = {
    Name        = "StaticWebsiteBucket"
    Environment = "Dev"
  }
}

# Enable static website hosting
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Allow public access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Bucket Policy for public read
resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.static_site.id

  depends_on = [aws_s3_bucket_public_access_block.public_access]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
      }
    ]
  })
}

# Upload index.html
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static_site.id
  key          = "index.html"
  source       = "index.html" # Make sure file exists in same folder
  content_type = "text/html"
}

# Upload error.html
resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.static_site.id
  key          = "error.html"
  source       = "error.html"
  content_type = "text/html"
}

#Copy terraform state file to S3
terraform {
  backend "s3" {
    bucket = "my-simple-terraform-state-12345"
    key    = "2nd-porject/terraform.tfstate"
    region = "ap-south-1"
  }
}
