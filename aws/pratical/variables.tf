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