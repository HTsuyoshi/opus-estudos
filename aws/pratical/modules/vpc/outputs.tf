output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ctfssi_a" {
  value = aws_subnet.public_subnet_ctfssi_a
}

output "public_subnet_challs_a" {
  value = aws_subnet.public_subnet_challs_a
}

output "public_subnet_challs_b" {
  value = aws_subnet.public_subnet_challs_b
}

output "aws_db_subnet_group" {
  value = aws_db_subnet_group.db_subnet_group
}