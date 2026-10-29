output "ec2_instance_public_ip" {
  description = "Public IP of EC2 Instance"
  value       = aws_instance.test-1.public_ip
}

