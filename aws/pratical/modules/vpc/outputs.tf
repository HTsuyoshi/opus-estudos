output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ctfssi_a_id" {
  value = aws_subnet.public_subnet_ctfssi_a.id
}

output "public_subnet_challs_a_id" {
  value = aws_subnet.public_subnet_challs_a.id
}

output "public_subnet_challs_b_id" {
  value = aws_subnet.public_subnet_challs_b.id
}

output "aws_db_subnet_group" {
  value = aws_db_subnet_group.db_subnet_group
}