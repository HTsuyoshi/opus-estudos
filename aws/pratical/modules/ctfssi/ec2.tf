# CTF-SSI security groups

resource "aws_security_group" "ctfssi_sg" {
  name        = "ctfssi_sg"
  description = "security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# CTF-SSI Instances

resource "aws_spot_instance_request" "ctfssi_2021_a" {
  instance_type          = var.spot_ec2["ctfssi"].instance_type
  spot_price             = var.spot_ec2["ctfssi"].spot_price
  ami                    = var.amazon_linux
  key_name               = var.ec2_keypair_id
  vpc_security_group_ids = [aws_security_group.ctfssi_sg.id]
  subnet_id              = var.public_subnet_ctfssi_a_id
  user_data              = var.ctfssi_2021_user_data
  wait_for_fulfillment = true

  root_block_device {
    volume_type = var.spot_ec2["ctfssi"].volume_type
    volume_size = var.spot_ec2["ctfssi"].volume_size
  }

  depends_on = [var.public_subnet_ctfssi_a_id, var.ctfssi_2021_user_data]

  tags = {
    Name      = "CTF-SSI 2021"
    Terraform = "true"
    Created   = timestamp()
  }
}

resource "aws_spot_instance_request" "ctfssi_2022_a" {
  instance_type          = var.spot_ec2["ctfssi"].instance_type
  spot_price             = var.spot_ec2["ctfssi"].spot_price
  ami                    = var.amazon_linux
  key_name               = var.ec2_keypair_id
  vpc_security_group_ids = [aws_security_group.ctfssi_sg.id]
  subnet_id              = var.public_subnet_ctfssi_a_id
  user_data              = var.ctfssi_2022_user_data
  wait_for_fulfillment = true

  root_block_device {
    volume_type = var.spot_ec2["ctfssi"].volume_type
    volume_size = var.spot_ec2["ctfssi"].volume_size
  }

  depends_on = [var.public_subnet_ctfssi_a_id, var.ctfssi_2022_user_data]

  tags = {
    Name      = "CTF-SSI 2022"
    Terraform = "true"
    Created   = timestamp()
  }
}

resource "aws_instance" "ctfssi_2023_a" {
  instance_type          = var.ec2["ctfssi"].instance_type
  ami                    = var.amazon_linux
  key_name               = var.ec2_keypair_id
  vpc_security_group_ids = [aws_security_group.ctfssi_sg.id]
  subnet_id              = var.public_subnet_ctfssi_a_id
  user_data              = var.ctfssi_2023_user_data

  root_block_device {
    volume_type = var.spot_ec2["ctfssi"].volume_type
    volume_size = var.spot_ec2["ctfssi"].volume_size
  }

  depends_on = [var.public_subnet_ctfssi_a_id, var.ctfssi_2023_user_data]

  tags = {
    Name      = "CTF-SSI 2023"
    Terraform = "true"
    Created   = timestamp()
  }
}
