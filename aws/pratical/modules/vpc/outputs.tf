output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_a" {
  value = aws_subnet.public_subnet_a
}

output "public_subnet_b" {
  value = aws_subnet.public_subnet_b
}

output "private_subnet_a" {
  value = aws_subnet.private_subnet_a
}

output "private_subnet_b" {
  value = aws_subnet.private_subnet_b
}

output "aws_db_subnet_group" {
  value = aws_db_subnet_group.db_subnet_group
}