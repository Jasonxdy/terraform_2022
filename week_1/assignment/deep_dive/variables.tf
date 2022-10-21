variable "tf_vpc_cidr" {
  description = "vpc cidr range"
  type = string
  default = "10.0.0.0/16"
}

variable "tf_subnet_cidr" {
  description = "public subnet cidr range"
  type = string
  default = "10.0.0.0/24"
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "terraform-dyc-web-server-instance"
}

variable "web_server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}