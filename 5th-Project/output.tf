output "aws_public_ip" {
  value = aws_instance.myec2.public_ip
}

output "instance_name" {
  value = aws_instance.myec2.tags["Name"]
}

