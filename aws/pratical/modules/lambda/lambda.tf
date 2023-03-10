#resource "aws_iam_role" "ctfssi_challs_start_instances_lambda_role" {
#  name = "start_ec2_lambda_role"
#
#  assume_role_policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Effect = "Allow"
#        Principal = {
#          Service = "lambda.amazonaws.com"
#        }
#        Action = "sts:AssumeRole"
#      }
#    ]
#  })
#}
#
#resource "aws_iam_role" "ctfssi_challs_stop_instances_lambda_role" {
#  name = "stop_ec2_lambda_role"
#
#  assume_role_policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Effect = "Allow"
#        Principal = {
#          Service = "lambda.amazonaws.com"
#        }
#        Action = "sts:AssumeRole"
#      }
#    ]
#  })
#}
#
#resource "aws_iam_policy" "start_ec2_lambda_policy" {
#  name = "start_ec2_lambda_policy"
#  policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Effect   = "Allow"
#        Action   = "ec2:StartInstances"
#        Resource = "*"
#      }
#    ]
#  })
#}
#
#resource "aws_iam_policy" "stop_ec2_lambda_policy" {
#  name = "stop_ec2_lambda_policy"
#  policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        Effect   = "Allow"
#        Action   = "ec2:StopInstances"
#        Resource = "*"
#      }
#    ]
#  })
#}
#
#resource "aws_iam_role_policy_attachment" "start_ec2_lambda_role_policy_attachment" {
#  policy_arn = aws_iam_policy.start_ec2_lambda_policy.arn
#  role   = aws_iam_role.ctfssi_challs_start_instances_lambda_role.name
#}
#
#resource "aws_iam_role_policy_attachment" "stop_ec2_lambda_role_policy_attachment" {
#  policy_arn = aws_iam_policy.stop_ec2_lambda_policy.arn
#  role   = aws_iam_role.ctfssi_challs_start_instances_lambda_role.name
#}
#
#resource "aws_lambda_function" "ctfssi_challs_start_instances_lambda" {
#  filename         = "start_instance_lambda.zip"
#  function_name    = "ctfssi_challs_start_instances_lambda"
#  handler          = "start_instance_lambda.lambda_handler"
#  runtime          = "python3.9"
#  source_code_hash = filebase64sha256("start_instance_lambda.zip")
#  timeout          = 60
#
#
#  role             = aws_iam_role.ctfssi_challs_start_instances_lambda_role.arn
#
#  #environment {
#  #  variables = {
#  #    INSTANCE_ID = aws_instance.example.id
#  #  }
#  #}
#}
#
#resource "aws_lambda_function" "ctfssi_challs_stop_instances_lambda" {
#  filename         = "stop_instance_lambda.zip"
#  function_name    = "ctfssi_challs_stop_instances_lambda"
#  handler          = "stop_instance_lambda.lambda_handler"
#  runtime          = "python3.9"
#  source_code_hash = filebase64sha256("stop_instance_lambda.zip")
#  timeout          = 60
#
#  role             = aws_iam_role.ctfssi_challs_stop_instances_lambda_role.arn
#
#  #environment {
#  #  variables = {
#  #    INSTANCE_ID = aws_instance.example.id
#  #  }
#  #}
#}
