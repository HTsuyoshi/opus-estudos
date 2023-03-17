output "ctfssi_2021_a_arn" {
  value = aws_spot_instance_request.ctfssi_2021_a.arn
}

output "ctfssi_2021_a_public_ip" {
  value = aws_spot_instance_request.ctfssi_2021_a.public_ip
}

output "ctfssi_2022_a_arn" {
  value = aws_spot_instance_request.ctfssi_2022_a.arn
}

output "ctfssi_2022_a_public_ip" {
  value = aws_spot_instance_request.ctfssi_2022_a.public_ip
}

output "ctfssi_2023_a_public_ip" {
  value = aws_instance.ctfssi_2023_a.public_ip
}

output "challs_2023_dns_name" {
  value = aws_lb.challs_2023_load_balancer.dns_name
}

output "challs_2023_zone_id" {
  value = aws_lb.challs_2023_load_balancer.zone_id
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.challs_2023_autoscaling.name
}

output "autoscaling_policy_scale_up_arn" {
  value = aws_autoscaling_policy.scale_up.arn
}

output "autoscaling_policy_scale_down_arn" {
  value = aws_autoscaling_policy.scale_down.arn
}