# RDS credentials

variable "db_credentials" {
  type = object({
    db_name     = string
    db_username = string
    db_password = string
  })

  default = {
    db_name     = "ctfd"
    db_username = "ctfd"
    db_password = "ctfdctfdctfd"
  }
}

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
