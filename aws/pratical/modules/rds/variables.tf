# RDS variables

variable "postgres" {
  type = object({
    engine                              = string
    engine_version                      = string
    instance_class                      = string
    allocated_storage                   = number
    max_allocated_storage               = number
    storage_encrypted                   = bool
    family                              = string
    port                                = string
    skip_final_snapshot                 = bool
    publicly_accessible                 = bool
    multi_az                            = bool
    availability_zone                   = string
    iam_database_authentication_enabled = bool
  })

  default = {
    engine                              = "mariadb"
    engine_version                      = "10.4"
    instance_class                      = "db.t2.micro"
    allocated_storage                   = 5
    max_allocated_storage               = 10
    storage_encrypted                   = false
    family                              = ""
    port                                = "3306"
    skip_final_snapshot                 = true
    publicly_accessible                 = false
    multi_az                            = false
    availability_zone                   = "us-east-1a"
    iam_database_authentication_enabled = false
  }
}

variable "vpc_id" {
  description = "ID of the VPC where the EC2 instance will be launched"
  type        = string
}

variable "aws_db_subnet_group_name" {
  description = "Name of the database subnet group"
  type        = string
}

variable "db_credentials" {
  type = object({
    db_name     = string
    db_username = string
    db_password = string
  })
}