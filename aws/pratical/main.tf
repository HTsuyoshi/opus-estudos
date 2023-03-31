terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.54.0"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "usp"
}

# AWS KeyPair

resource "aws_key_pair" "auth" {
  key_name   = "key"
  public_key = file("~/.ssh/ec2_aws.pub")
}

# CloudFront: Certificate

data "aws_acm_certificate" "intheshell_crt" {
  domain   = "intheshell.page"
  statuses = ["ISSUED"]
}

# EC2: AMI

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}

# EC2: Userdata templates

data "template_file" "challs_2021" {
  template = file("${path.module}/templates/challs-2021.tpl")
}

data "template_file" "ctfssi_2021" {
  template = file("${path.module}/templates/ctfssi-2021.tpl")
}

data "template_file" "ctfssi_2022" {
  template = file("${path.module}/templates/ctfssi-2022.tpl")
}

data "template_file" "ctfssi_2023" {
  template = file("${path.module}/templates/ctfssi-2023.tpl")

  vars = {
    db_name     = var.db_credentials.db_name
    db_username = var.db_credentials.db_username
    db_password = var.db_credentials.db_password
    db_url      = module.rds.db_endpoint
  }
}

# Modules

module "vpc" {
  source = "./modules/vpc"
}

module "rds" {
  source = "./modules/rds"
  vpc_id = module.vpc.vpc_id
  aws_db_subnet_group_name = module.vpc.aws_db_subnet_group.name
  db_credentials            = var.db_credentials
}

module "ctfssi" {
  source         = "./modules/ctfssi"
  ec2_keypair_id = aws_key_pair.auth.id
  vpc_id         = module.vpc.vpc_id
  amazon_linux   = data.aws_ami.amazon_linux.id
  ec2            = var.ec2
  spot_ec2       = var.spot_ec2

  db_credentials            = var.db_credentials
  ctfssi_2021_user_data     = data.template_file.ctfssi_2021.rendered
  ctfssi_2022_user_data     = data.template_file.ctfssi_2022.rendered
  ctfssi_2023_user_data     = data.template_file.ctfssi_2023.rendered
  public_subnet_ctfssi_a_id = module.vpc.public_subnet_ctfssi_a_id

  depends_on = [
    module.rds
  ]
}

module "challs" {
  source         = "./modules/challs"
  ec2_keypair_id = aws_key_pair.auth.id
  vpc_id         = module.vpc.vpc_id
  amazon_linux   = data.aws_ami.amazon_linux.id
  ec2            = var.ec2
  spot_ec2       = var.spot_ec2

  challs_2021_user_data     = data.template_file.challs_2021.rendered
  public_subnet_challs_a_id = module.vpc.public_subnet_challs_a_id
  public_subnet_challs_b_id = module.vpc.public_subnet_challs_b_id
}

module "r53" {
  source                  = "./modules/53"
  ctfssi_2021_a_public_ip = module.ctfssi.ctfssi_2021_a_public_ip
  ctfssi_2022_a_public_ip = module.ctfssi.ctfssi_2022_a_public_ip
  ctfssi_2023_a_public_ip = module.ctfssi.ctfssi_2023_a_public_ip
  challs_2021_a_public_ip = module.challs.challs_2021_a_public_ip
  challs_2022_a_public_ip = module.challs.challs_2022_a_public_ip
  challs_2023_dns_name    = module.challs.challs_2023_dns_name
  challs_2023_zone_id     = module.challs.challs_2023_zone_id

  depends_on = [
    module.ctfssi,
    module.ctfssi.ctfssi_2021_a_public_ip,
    module.ctfssi.ctfssi_2022_a_public_ip,
    module.ctfssi.ctfssi_2023_a_public_ip,
    module.challs,
    module.challs.challs_2021_a_public_ip,
    module.challs.challs_2022_a_public_ip,
    module.challs.challs_2023_dns_name,
    module.challs.challs_2023_zone_id
  ]
}