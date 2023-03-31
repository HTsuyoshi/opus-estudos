output "challs_2021_a_public_ip" {
  value = aws_spot_instance_request.challs_2022_a.public_ip
}

output "challs_2022_a_public_ip" {
  value = aws_spot_instance_request.challs_2022_a.public_ip
}

#output "challs_2021_a_public_ip" {
#  value = aws_spot_instance_request.challs_2021_a.public_ip
#}
#
#output "challs_2022_a_public_ip" {
#  value = aws_spot_instance_request.challs_2022_a.public_ip
#}

output "challs_2023_dns_name" {
  value = aws_lb.challs_2023_load_balancer.dns_name
}

output "challs_2023_zone_id" {
  value = aws_lb.challs_2023_load_balancer.zone_id
}