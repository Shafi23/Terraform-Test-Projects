output "display" {
value = random_string.mygen
}

output "S3_name" {
    value = aws_s3_bucket.mys3.bucket  
}

