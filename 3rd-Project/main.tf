terraform {

  backend "s3" {
    bucket = "bucket-for-terraform-2610"
    key    = "instance/terraform.tfstate"
    region = "ap-south-1"
  }
}

resource "aws_instance" "test-1" {
  ami           = var.ami
  instance_type = var.ec2-type

  tags = {
    Name = "My-test-1-Ec2"
  }
}

