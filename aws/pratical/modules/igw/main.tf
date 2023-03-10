resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = "ctfssi_igw"
    Terraform = "true"
    Created   = timestamp()
  }
}