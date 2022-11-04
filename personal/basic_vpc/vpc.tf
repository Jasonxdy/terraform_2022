provider "aws" {
  region = "ap-northeast-2"
}

# vpc 생성
resource "aws_vpc" "tf_vpc" {
  cidr_block = var.tf_vpc_cidr
  enable_dns_hostnames = true
  tags = {
    "Name" = "terraform_vpc_basic"
  }
}


# public subnet a 생성
resource "aws_subnet" "tf_public_subnet_pub_a" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = var.tf_subnet_cidr_pub_a
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "terraform_sbn_pub_a"
  }
}

# public subnet c 생성
resource "aws_subnet" "tf_public_subnet_pub_c" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = var.tf_subnet_cidr_pub_c
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "terraform_sbn_pub_c"
  }
}

# private subnet a 생성
resource "aws_subnet" "tf_public_subnet_pri_a" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = var.tf_subnet_cidr_pri_a
  availability_zone = "ap-northeast-2a"
  tags = {
    "Name" = "terraform_sbn_pri_a"
  }
}

# private subnet c 생성
resource "aws_subnet" "tf_public_subnet_pri_c" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = var.tf_subnet_cidr_pri_c
  availability_zone = "ap-northeast-2c"
  tags = {
    "Name" = "terraform_sbn_pri_c"
  }
}


# internet gateway 생성
resource "aws_internet_gateway" "tf_internet_gateway" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    "Name" = "terraform_igw"
  }
}

# EIP 생성
resource "aws_eip" "tf_eip" {
  lifecycle {
    create_before_destroy = true
  }  
}

# nat gateway 생성
resource "aws_nat_gateway" "tf_nat_gateway" {
  allocation_id = aws_eip.tf_eip.id
  subnet_id = aws_subnet.tf_public_subnet_pub_a.id
  tags = {
    "Name" = "terraform_nat"
  }

  depends_on = [
    aws_internet_gateway.tf_internet_gateway
  ]
  
}

# #internet gateway attachment 생성
# resource "aws_internet_gateway_attachment" "tf_internet_gateway_attachment" {
#   internet_gateway_id = aws_internet_gateway.tf_internet_gateway.id
#   vpc_id = aws_vpc.tf_vpc.id
# }

# pub route table 생성
resource "aws_route_table" "tf_route_table_pub" {
  vpc_id = aws_vpc.tf_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_internet_gateway.id
  }
}
# pri route table 생성
resource "aws_route_table" "tf_route_table_pri" {
  vpc_id = aws_vpc.tf_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.tf_nat_gateway.id
  }
}

# pub-a route table subnet association 생성
resource "aws_route_table_association" "tf_rta_pub_a" {
  subnet_id = aws_subnet.tf_public_subnet_pub_a.id
  route_table_id = aws_route_table.tf_route_table_pub.id
}
# pub-a route table subnet association 생성
resource "aws_route_table_association" "tf_rta_pub_c" {
  subnet_id = aws_subnet.tf_public_subnet_pub_c.id
  route_table_id = aws_route_table.tf_route_table_pub.id
}
# pub-a route table subnet association 생성
resource "aws_route_table_association" "tf_rta_pri_a" {
  subnet_id = aws_subnet.tf_public_subnet_pri_a.id
  route_table_id = aws_route_table.tf_route_table_pri.id
}
# pub-a route table subnet association 생성
resource "aws_route_table_association" "tf_rta_pri_c" {
  subnet_id = aws_subnet.tf_public_subnet_pri_c.id
  route_table_id = aws_route_table.tf_route_table_pri.id
}


# 웹서버 생성
# resource "aws_instance" "ubuntu_server" {
#   ami                    = "ami-0e9bfdb247cc8de84"
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [aws_security_group.instance.id]
#   subnet_id = aws_subnet.tf_public_subnet.id
#   associate_public_ip_address = true

#   user_data = <<-EOF
#               #!/bin/bash
#               echo "Hello, DongYoung Cho" > index.html
#               nohup busybox httpd -f -p 8080 &
#               EOF
#   user_data_replace_on_change = true
  
#   tags = {
#     Name = "Web-Server-DYC"
#   }
# }

# # 웹서버 보안그룹 생성
# resource "aws_security_group" "instance" {
#   name = var.security_group_name
#   vpc_id = aws_vpc.tf_vpc.id
#   ingress {
#     from_port   = var.web_server_port
#     to_port     = var.web_server_port
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
