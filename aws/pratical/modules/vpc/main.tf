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

resource "aws_subnet" "public_subnet_ctfssi_a" {
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

resource "aws_subnet" "private_subnet_db_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name      = "ctfssi_private"
    Terraform = "true"
    Created   = timestamp()
  }
}

resource "aws_subnet" "private_subnet_db_b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name      = "ctfssi_private"
    Terraform = "true"
    Created   = timestamp()
  }
}

resource "aws_subnet" "public_subnet_challs_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name      = "ctfssi_private"
    Terraform = "true"
    Created   = timestamp()
  }
}

resource "aws_subnet" "public_subnet_challs_b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name      = "ctfssi_private"
    Terraform = "true"
    Created   = timestamp()
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "example-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_db_a.id, aws_subnet.private_subnet_db_b.id]
}

resource "aws_route_table" "public_rt_ctfssi_a" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name      = "public_rt_ctfssi_a"
    Terraform = "true"
    Created   = timestamp()
  }
}

resource "aws_route" "igw_route_ctfssi_a" {
  route_table_id         = aws_route_table.public_rt_ctfssi_a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "public_assoc_ctfssi_a" {
  subnet_id      = aws_subnet.public_subnet_ctfssi_a.id
  route_table_id = aws_route_table.public_rt_ctfssi_a.id
}

resource "aws_route_table" "public_rt_challs_a" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name      = "public_rt_ctfssi_a"
    Terraform = "true"
    Created   = timestamp()
  }
}

resource "aws_route" "igw_route_challs_a" {
  route_table_id         = aws_route_table.public_rt_challs_a.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "public_assoc_challs_a" {
  subnet_id      = aws_subnet.public_subnet_challs_a.id
  route_table_id = aws_route_table.public_rt_challs_a.id
}

resource "aws_route_table" "public_rt_challs_b" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name      = "public_rt_ctfssi_a"
    Terraform = "true"
    Created   = timestamp()
  }
}

resource "aws_route" "igw_route_challs_b" {
  route_table_id         = aws_route_table.public_rt_challs_b.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "public_assoc_challs_b" {
  subnet_id      = aws_subnet.public_subnet_challs_b.id
  route_table_id = aws_route_table.public_rt_challs_b.id
}

### VERIFICAR ###
resource "aws_network_acl" "public_nacl" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port  = 22
    to_port    = 22
    protocol   = "tcp"
    cidr_block = "0.0.0.0/0"
    rule_no    = 100
    action     = "allow"
  }

  ingress {
    from_port  = 80
    to_port    = 80
    protocol   = "tcp"
    cidr_block = "0.0.0.0/0"
    rule_no    = 110
    action     = "allow"
  }

  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
    rule_no    = 200
    action     = "allow"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name      = "igw"
    Terraform = "true"
    Created   = timestamp()
  }
}

## Arrumar elastic IP
#resource "aws_eip" "lb" {
#  instance = aws_instance.web.id
#  vpc      = true
#}