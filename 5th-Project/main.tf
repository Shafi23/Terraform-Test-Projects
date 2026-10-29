resource "random_string" "my_random_string" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_instance" "myec2" {
  ami           = var.myami
  instance_type = var.my_instance
  tags = {
    Name = "myec2-${random_string.my_random_string.result}"
  }
}

