resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name      = "ctfssi"
    Terraform = "true"
    Created   = timestamp()
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name      = "ctfssi_public"
    Terraform = "true"
    Created   = timestamp()
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name      = "ctfssi_public"
    Terraform = "true"
    Created   = timestamp()
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name      = "ctfssi_private"
    Terraform = "true"
    Created   = timestamp()
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name      = "ctfssi_private"
    Terraform = "true"
    Created   = timestamp()
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "example-db-subnet-group"
  subnet_ids = [ aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id ]
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "challs_public_rt"
    Terraform = "true"
    Created   = timestamp()
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_network_acl" "public_nacl" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_block  = "0.0.0.0/0"
    rule_no = 100
    action = "allow"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_block  = "0.0.0.0/0"
    rule_no = 101
    action = "allow"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_block  = "0.0.0.0/0"
    rule_no = 100
    action = "allow"
  }
}