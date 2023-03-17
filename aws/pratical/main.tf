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
  source = "./modules/vpc"
}

module "ec2" {
  source                = "./modules/ec2"
  vpc_id                = module.vpc.vpc_id
  amazon_linux          = data.aws_ami.amazon_linux.id
  public_subnet_ctfssi_a_id    = module.vpc.public_subnet_ctfssi_a.id
  public_subnet_challs_a_id    = module.vpc.public_subnet_challs_a.id
  public_subnet_challs_b_id    = module.vpc.public_subnet_challs_b.id
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

module "r53" {
  source                  = "./modules/53"
  ctfssi_2021_a_public_ip = module.ec2.ctfssi_2021_a_public_ip
  ctfssi_2022_a_public_ip = module.ec2.ctfssi_2022_a_public_ip
  ctfssi_2023_a_public_ip = module.ec2.ctfssi_2023_a_public_ip
  challs_2023_dns_name    = module.ec2.challs_2023_dns_name
  challs_2023_zone_id     = module.ec2.challs_2023_zone_id
}

module "cw" {
  source                            = "./modules/cw"
  autoscaling_policy_scale_up_arn   = module.ec2.autoscaling_policy_scale_up_arn
  autoscaling_policy_scale_down_arn = module.ec2.autoscaling_policy_scale_down_arn
  autoscaling_group_name            = module.ec2.autoscaling_group_name
  #ctfssi_2021_a_arn                 = module.ec2.ctfssi_2021_a_arn
  #ctfssi_2022_a_arn                 = module.ec2.ctfssi_2022_a_arn
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
    db_url      = module.rds.endpoint
  }
}