output "ctfssi_2021_a_public_ip" {
  value = aws_spot_instance_request.ctfssi_2021_a.public_ip
}

output "ctfssi_2022_a_public_ip" {
  value = aws_spot_instance_request.ctfssi_2022_a.public_ip
}

#output "ctfssi_2022_a_public_ip" {
#  value = aws_spot_instance_request.ctfssi_2022_a.public_ip
#}

output "ctfssi_2023_a_public_ip" {
  value = aws_instance.ctfssi_2023_a.public_ip
}