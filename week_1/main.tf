provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "ubuntu_server" {
  ami                    = "ami-0e9bfdb247cc8de84"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, DongYoung Cho" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "Web-Server-DYC"
  }
}

resource "aws_security_group" "instance" {
  name = var.security_group_name

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "terraform-example-instance"
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the Instance"
}