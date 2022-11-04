variable "tf_vpc_cidr" {
  description = "vpc cidr range"
  type = string
  default = "10.0.0.0/16"
}

variable "tf_subnet_cidr_pub_a" {
  description = "public subnet cidr range"
  type = string
  default = "10.0.0.0/24"
}
variable "tf_subnet_cidr_pub_c" {
  description = "public subnet cidr range"
  type = string
  default = "10.0.1.0/24"
}
variable "tf_subnet_cidr_pri_a" {
  description = "public subnet cidr range"
  type = string
  default = "10.0.2.0/24"
}
variable "tf_subnet_cidr_pri_c" {
  description = "public subnet cidr range"
  type = string
  default = "10.0.3.0/24"
}

# variable "security_group_name" {
#   description = "The name of the security group"
#   type        = string
#   default     = "terraform-dyc-web-server-instance"
# }

# variable "web_server_port" {
#   description = "The port the server will use for HTTP requests"
#   type        = number
#   default     = 8080
# }