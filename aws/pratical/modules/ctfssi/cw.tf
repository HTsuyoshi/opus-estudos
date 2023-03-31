# Arrumar
#resource "aws_cloudwatch_event_rule" "restart_monthly" {
#  name                = "restart_monthly"
#  description         = "Restart EC2 instance monthly at 8 AM UTC"
#  schedule_expression = "cron(0 8 1 * ? *)"
#}
#
#resource "aws_cloudwatch_event_rule" "restart_test" {
#  name                = "restart_test"
#  description         = "Restart EC2 instance monthly at 0 AM UTC"
#  schedule_expression = "cron(0/1 * * * ? *)"
#}

#resource "aws_cloudwatch_event_target" "restart_ctfssi_2021_a" {
#  target_id = "restart_ctfssi_2021_a"
#  rule      = aws_cloudwatch_event_rule.restart_test.name
#  arn       = var.ctfssi_2021_a_arn
#  input = jsonencode({
#    "instance-id": var.ctfssi_2021_a_arn,
#    "type": "reboot"
#  })
#  depends_on = [var.ctfssi_2021_a_arn]
#}
#
#resource "aws_cloudwatch_event_target" "restart_ctfssi_2022_a" {
#  target_id = "restart_ctfssi_2022_a"
#  rule      = aws_cloudwatch_event_rule.restart_test.name
#  arn       = var.ctfssi_2022_a_arn
#  input = jsonencode({
#    "instance-id": var.ctfssi_2022_a_arn,
#    "type": "reboot"
#  })
#  depends_on = [var.ctfssi_2022_a_arn]
#}











# Desisti
#resource "aws_cloudwatch_metric_alarm" "ctfssi_2021_idle_ec2_alarm" {
#  alarm_name          = "networking-alarm"
#  comparison_operator = "LessThanOrEqualToThreshold"
#  evaluation_periods  = "1"
#  metric_name         = "NetworkIn"
#  namespace           = "AWS/EC2"
#  period              = "180"
#  statistic           = "Sum"
#  threshold           = "10000"
#  alarm_description   = "Alarm when EC2 instance networking is less than 10000 bytes"
#  dimensions = {
#    InstanceId = aws_instance.ctfssi_2021_a.id
#  }
#}
#
#resource "aws_cloudwatch_metric_alarm" "ctfssi_2022_idle_ec2_alarm" {
#  alarm_name          = "networking-alarm"
#  comparison_operator = "LessThanOrEqualToThreshold"
#  evaluation_periods  = "1"
#  metric_name         = "NetworkIn"
#  namespace           = "AWS/EC2"
#  period              = "180"
#  statistic           = "Sum"
#  threshold           = "10000"
#  alarm_description   = "Alarm when EC2 instance networking is less than 10000 bytes"
#  dimensions = {
#    InstanceId = aws_instance.ctfssi_2022_a.id
#  }
#}
#
#resource "aws_cloudwatch_metric_alarm" "ctfssi_2023_idle_ec2_alarm" {
#  alarm_name          = "networking-alarm"
#  comparison_operator = "LessThanOrEqualToThreshold"
#  evaluation_periods  = "1"
#  metric_name         = "NetworkIn"
#  namespace           = "AWS/EC2"
#  period              = "180"
#  statistic           = "Sum"
#  threshold           = "10000"
#  alarm_description   = "Alarm when EC2 instance networking is less than 10000 bytes"
#  dimensions = {
#    InstanceId = aws_instance.ctfssi_2023_a.id
#  }
#}

#resource "aws_cloudwatch_metric_alarm" "challs_2021_idle_ec2_alarm" {
#  alarm_name          = "networking-alarm"
#  comparison_operator = "LessThanOrEqualToThreshold"
#  evaluation_periods  = "1"
#  metric_name         = "NetworkIn"
#  namespace           = "AWS/EC2"
#  period              = "180"
#  statistic           = "Sum"
#  threshold           = "10000"
#  alarm_description   = "Alarm when EC2 instance networking is less than 10000 bytes"
#  actions_enabled = true
#  ok_actions = [ "arn:aws:automate:us-east-1:ec2:stop" ]
#  alarm_actions = [ "arn:aws:automate:us-east-1:ec2:reboot" ]
#  #alarm_actions = [ "arn:aws:automate:us-east-1::instace-start" ]
#  dimensions = {
#    InstanceId = aws_instance.challs_2021_a.id
#  }
#}

#resource "aws_cloudwatch_metric_alarm" "challs_2022_idle_ec2_alarm" {
#  alarm_name          = "networking-alarm"
#  comparison_operator = "LessThanOrEqualToThreshold"
#  evaluation_periods  = "1"
#  metric_name         = "NetworkIn"
#  namespace           = "AWS/EC2"
#  period              = "180"
#  statistic           = "Sum"
#  threshold           = "10000"
#  alarm_description   = "Alarm when EC2 instance networking is less than 10000 bytes"
#  dimensions = {
#    InstanceId = aws_instance.challs_2022_a.id
#  }
#}
#
#resource "aws_cloudwatch_metric_alarm" "challs_2023_a_idle_ec2_alarm" {
#  alarm_name          = "networking-alarm"
#  comparison_operator = "LessThanOrEqualToThreshold"
#  evaluation_periods  = "1"
#  metric_name         = "NetworkIn"
#  namespace           = "AWS/EC2"
#  period              = "180"
#  statistic           = "Sum"
#  threshold           = "10000"
#  alarm_description   = "Alarm when EC2 instance networking is less than 10000 bytes"
#  dimensions = {
#    InstanceId = aws_instance.challs_2023_a.id
#  }
#}
#
#resource "aws_cloudwatch_metric_alarm" "challs_2023_b_idle_ec2_alarm" {
#  alarm_name          = "networking-alarm"
#  comparison_operator = "LessThanOrEqualToThreshold"
#  evaluation_periods  = "1"
#  metric_name         = "NetworkIn"
#  namespace           = "AWS/EC2"
#  period              = "180"
#  statistic           = "Sum"
#  threshold           = "10000"
#  alarm_description   = "Alarm when EC2 instance networking is less than 10000 bytes"
#  dimensions = {
#    InstanceId = aws_instance.challs_2023_b.id
#  }
#}