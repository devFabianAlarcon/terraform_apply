provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "mi_lambda_function" {
  function_name    = "mi-lambda-function"
  handler          = "main.handler"
  runtime          = "nodejs14.x"
  filename         = "mi-lambda-function.zip"
  source_code_hash = filebase64("main.js")

  role = aws_iam_role.mi_lambda_role.arn

  depends_on = [aws_iam_role_policy_attachment.lambda_attachment]
}

resource "aws_iam_role" "mi_lambda_role" {
  name = "mi-lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.mi_lambda_role.name
}
