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

module "vpc" {
  source              = "./modules/vpc"
  internet_gateway_id = module.igw.internet_gateway.id
}

module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source                = "./modules/ec2"
  vpc_id                = module.vpc.vpc_id
  amazon_linux          = data.aws_ami.amazon_linux.id
  public_subnet_a_id    = module.vpc.public_subnet_a.id
  public_subnet_b_id    = module.vpc.public_subnet_b.id
  challs_2021_user_data = data.template_file.challs_2021.rendered
  ctfssi_2021_user_data = data.template_file.ctfssi_2021.rendered
  ctfssi_2022_user_data = data.template_file.ctfssi_2022.rendered
  ctfssi_2023_user_data = data.template_file.ctfssi_2023.rendered
}

module "rds" {
  source                   = "./modules/rds"
  vpc_id                   = module.vpc.vpc_id
  aws_db_subnet_group_name = module.vpc.aws_db_subnet_group.name
  db_credentials           = var.db_credentials
}

#module "cf" {
#  source = "./modules/vpc"
#}
#
#module "cw" {
#  source = "./modules/ec2"
#  vpc_id = module.vpc.vpc_id
#}

# CloudFront: Certificate

data "aws_acm_certificate" "intheshell_crt" {
  domain   = "intheshell.page"
  statuses = ["ISSUED"]
}

# Route 53: Create endpoints

data "aws_route53_zone" "intheshell" {
  name         = "intheshell.page."
  private_zone = false
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
    db_url      = module.rds.endpoint
  }
}