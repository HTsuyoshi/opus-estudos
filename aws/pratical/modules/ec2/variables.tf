# EC2 variables

variable "spot_ec2" {
  type = map(object({
    instance_type = string
    spot_price    = string
    volume_type   = string
    volume_size   = number
  }))

  default = {
    ctfssi = {
      instance_type = "t3.micro"
      spot_price    = "0.005"
      volume_type   = "standard"
      volume_size   = 8
    }
    challs = {
      instance_type = "t3.micro"
      spot_price    = "0.005"
      volume_type   = "standard"
      volume_size   = 8
    }
  }
}

variable "ec2" {
  type = map(object({
    instance_type = string
    volume_type   = string
    volume_size   = number
  }))

  default = {
    ctfssi = {
      instance_type = "t3.micro"
      volume_type   = "standard"
      volume_size   = 8
    }
    challs = {
      instance_type = "t3.micro"
      volume_type   = "standard"
      volume_size   = 8
    }
  }
}

variable "vpc_id" {
  description = "ID of the VPC where the EC2 instance will be launched"
  type = string
}

variable "amazon_linux" {
  description = "Amazon Linux 2 image"
  type = string
}

variable "public_subnet_a_id" {
  description = "Subnet"
  type = string
}

variable "public_subnet_b_id" {
  description = "Subnet"
  type = string
}

variable "challs_2021_user_data" {
  description = "User data for the challenges EC2"
  type = string
}

variable "ctfssi_2021_user_data" {
  description = "User data for the ctfd EC2"
  type = string
}

variable "ctfssi_2022_user_data" {
  description = "User data for the ctfd EC2"
  type = string
}

variable "ctfssi_2023_user_data" {
  description = "User data for the ctfd EC2"
  type = string
}
