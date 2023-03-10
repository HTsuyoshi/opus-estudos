# AWS KeyPair

resource "aws_key_pair" "auth" {
  key_name   = "key"
  public_key = file("~/.ssh/ec2_aws.pub")
}

# CTF-SSI security groups

resource "aws_security_group" "ctfssi_sg" {
  name        = "ctfssi_sg"
  description = "security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## CTF-SSI Instances
#
#resource "aws_spot_instance_request" "ctfssi_2021_a" {
#  instance_type          = var.spot_ec2["ctfssi"].instance_type
#  spot_price             = var.spot_ec2["ctfssi"].spot_price
#  ami                    = var.amazon_linux
#  key_name               = aws_key_pair.auth.id
#  vpc_security_group_ids = [aws_security_group.ctfssi_sg.id]
#  subnet_id              = var.public_subnet_a_id
#  user_data              = var.ctfssi_2021_user_data
#
#  root_block_device {
#    volume_type = var.spot_ec2["ctfssi"].volume_type
#    volume_size = var.spot_ec2["ctfssi"].volume_size
#  }
#
#  tags = {
#    Name      = "CTF-SSI 2021"
#    Terraform = "true"
#    Created   = timestamp()
#  }
#}
#
#resource "aws_spot_instance_request" "ctfssi_2022_a" {
#  instance_type          = var.spot_ec2["ctfssi"].instance_type
#  spot_price             = var.spot_ec2["ctfssi"].spot_price
#  ami                    = var.amazon_linux
#  key_name               = aws_key_pair.auth.id
#  vpc_security_group_ids = [aws_security_group.ctfssi_sg.id]
#  subnet_id              = var.public_subnet_a_id
#  user_data              = var.ctfssi_2022_user_data
#
#  root_block_device {
#    volume_type = var.spot_ec2["ctfssi"].volume_type
#    volume_size = var.spot_ec2["ctfssi"].volume_size
#  }
#
#  tags = {
#    Name      = "CTF-SSI 2022"
#    Terraform = "true"
#    Created   = timestamp()
#  }
#}
#
resource "aws_instance" "ctfssi_2023_a" {
  instance_type          = var.ec2["ctfssi"].instance_type
  ami                    = var.amazon_linux
  key_name               = aws_key_pair.auth.id
  vpc_security_group_ids = [ aws_security_group.ctfssi_sg.id ]
  subnet_id              = var.public_subnet_a_id
  user_data              = var.ctfssi_2023_user_data

  root_block_device {
    volume_type = var.spot_ec2["ctfssi"].volume_type
    volume_size = var.spot_ec2["ctfssi"].volume_size
  }

  tags = {
    Name      = "CTF-SSI 2023"
    Terraform = "true"
    Created   = timestamp()
  }
}

# 2021 Challenges security group

resource "aws_security_group" "challs_sg" {
  name        = "challs_sg"
  description = "security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#
#resource "aws_spot_instance_request" "challs_2021_a" {
#  instance_type          = var.spot_ec2["challs"].instance_type
#  spot_price             = var.spot_ec2["challs"].spot_price
#  ami                    = var.amazon_linux
#  key_name               = aws_key_pair.auth.id
#  vpc_security_group_ids = [aws_security_group.challs_sg.id]
#  subnet_id              = var.public_subnet_a_id
#  user_data              = var.challs_2021_user_data
#
#  root_block_device {
#    volume_type = var.spot_ec2["challs"].volume_type
#    volume_size = var.spot_ec2["challs"].volume_size
#  }
#
#  tags = {
#    Name      = "CTF-SSI 2021 - Desafios"
#    Terraform = "true"
#    Created   = timestamp()
#  }
#}
#
## 2022 Challenges instances
#
#resource "aws_spot_instance_request" "challs_2022_a" {
#  instance_type          = var.spot_ec2["challs"].instance_type
#  spot_price             = var.spot_ec2["challs"].spot_price
#  ami                    = var.amazon_linux
#  key_name               = aws_key_pair.auth.id
#  vpc_security_group_ids = [aws_security_group.challs_sg.id]
#  subnet_id              = var.public_subnet_a_id
#  user_data              = var.challs_2021_user_data
#
#  root_block_device {
#    volume_type = var.spot_ec2["challs"].volume_type
#    volume_size = var.spot_ec2["challs"].volume_size
#  }
#
#  tags = {
#    Name      = "CTF-SSI 2022 - Desafios"
#    Terraform = "true"
#    Created   = timestamp()
#  }
#}
#
## 2023 Challenges instances
#
#resource "aws_instance" "challs_2023_a" {
#  instance_type          = var.ec2["challs"].instance_type
#  ami                    = var.amazon_linux
#  key_name               = aws_key_pair.auth.id
#  vpc_security_group_ids = [aws_security_group.challs_sg.id]
#  subnet_id              = var.public_subnet_a_id
#  user_data              = var.challs_2021_user_data
#
#  root_block_device {
#    volume_type = var.spot_ec2["challs"].volume_type
#    volume_size = var.spot_ec2["challs"].volume_size
#  }
#
#  tags = {
#    Name      = "CTF-SSI 2023 - Desafios"
#    Terraform = "true"
#    Created   = timestamp()
#  }
#}
#
#resource "aws_instance" "challs_2023_b" {
#  instance_type          = var.ec2["challs"].instance_type
#  ami                    = var.amazon_linux
#  key_name               = aws_key_pair.auth.id
#  vpc_security_group_ids = [aws_security_group.challs_sg.id]
#  subnet_id              = var.public_subnet_b_id
#  user_data              = var.challs_2021_user_data
#
#  root_block_device {
#    volume_type = var.spot_ec2["challs"].volume_type
#    volume_size = var.spot_ec2["challs"].volume_size
#  }
#
#  tags = {
#    Name      = "CTF-SSI 2023 - Desafios"
#    Terraform = "true"
#    Created   = timestamp()
#  }
#}

resource "aws_launch_template" "challs_2023_template" {
  name_prefix            = "challs_2023"
  image_id               = var.amazon_linux
  instance_type          = var.ec2["challs"].instance_type
  key_name               = aws_key_pair.auth.id
  user_data              = base64encode(var.challs_2021_user_data)

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [ aws_security_group.challs_sg.id ]
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_type = var.spot_ec2["challs"].volume_type
      volume_size = var.spot_ec2["challs"].volume_size
      delete_on_termination = true
    }
  }
}

resource "aws_autoscaling_group" "challs_2023_autoscaling" {
  name                 = "chall_2023_autoscaling"
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = [ var.public_subnet_a_id, var.public_subnet_a_id ]

  health_check_grace_period = 300
  health_check_type         = "ELB"

  launch_template {
    id = aws_launch_template.challs_2023_template.id
    version = aws_launch_template.challs_2023_template.latest_version
  }

  timeouts {
    delete = "5m"
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }

  tag {
    key                 = "Created"
    value               = timestamp()
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "scale_up" {
  name   = "challs_2023_scale_up"
  autoscaling_group_name = aws_autoscaling_group.challs_2023_autoscaling.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "1"
  cooldown = "300"
  policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name = "chall_2023_alarm_scale_up"
  alarm_description = "asg-scale-up-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "80"
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.challs_2023_autoscaling.name
  }
  actions_enabled = true
  alarm_actions = [ aws_autoscaling_policy.scale_up.arn ]
}

resource "aws_autoscaling_policy" "scale_down" {
  name   = "challs_2023_scale_down"
  autoscaling_group_name = aws_autoscaling_group.challs_2023_autoscaling.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "-1"
  cooldown = "300"
  policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name = "chall_2023_alarm_scale_down"
  alarm_description = "asg-scale-up-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "50"
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.challs_2023_autoscaling.name
  }
  actions_enabled = true
  alarm_actions = [ aws_autoscaling_policy.scale_down.arn ]
}