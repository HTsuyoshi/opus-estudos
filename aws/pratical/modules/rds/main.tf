
# CTF-SSI 2023 Database security groups

resource "aws_security_group" "ctfssi_2023_db_sg" {
  name        = "ctfssi_2023_db_sg"
  description = "security group"
  vpc_id      = var.vpc_id

  ingress {
    description = "MariaDB port"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "ctfssi_2023_db" {
  identifier = "ctfssi-2023-db"

  engine                = var.postgres.engine
  engine_version        = var.postgres.engine_version
  instance_class        = var.postgres.instance_class
  allocated_storage     = var.postgres.allocated_storage
  max_allocated_storage = var.postgres.max_allocated_storage
  storage_encrypted     = var.postgres.storage_encrypted

  db_name  = var.db_credentials.db_name
  username = var.db_credentials.db_username
  password = var.db_credentials.db_password
  port     = var.postgres.port

  iam_database_authentication_enabled = var.postgres.iam_database_authentication_enabled

  skip_final_snapshot = var.postgres.skip_final_snapshot
  publicly_accessible = var.postgres.publicly_accessible

  multi_az               = var.postgres.multi_az
  availability_zone      = var.postgres.availability_zone
  db_subnet_group_name   = var.aws_db_subnet_group_name
  vpc_security_group_ids = [aws_security_group.ctfssi_2023_db_sg.id]

  tags = {
    Name      = "RDS - 2023"
    Terraform = "true"
    Created   = timestamp()
  }
}