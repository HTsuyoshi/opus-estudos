variable "ec2_keypair_id" {
  description = "Pulic key used to connect into the EC2 instance"
  type        = string
}

variable "amazon_linux" {
  description = "Amazon Linux 2 image"
  type        = string
}

variable "spot_ec2" {
  description = "Pulic key used to connect into the EC2 instance"
  type = map(object({
    instance_type = string
    spot_price    = string
    volume_type   = string
    volume_size   = number
  }))
}

variable "ec2" {
  description = "Pulic key used to connect into the EC2 instance"
  type = map(object({
    instance_type = string
    volume_type   = string
    volume_size   = number
  }))
}

variable "challs_2021_user_data" {
  description = "User data for the challenges EC2"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the EC2 instance will be launched"
  type        = string
}

variable "public_subnet_challs_a_id" {
  description = "Subnet"
  type        = string
}

variable "public_subnet_challs_b_id" {
  description = "Subnet"
  type        = string
}