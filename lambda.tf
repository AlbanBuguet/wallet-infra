# wallet-notifier, which pushes the gate changes and the delays to the passes.
resource "aws_lambda_function" "notifier" {
  function_name = "${local.name}-notifier"
  role          = aws_iam_role.notifier.arn
  runtime       = "python3.12"
  handler       = "notifier.handler.handle"
  s3_bucket     = "${local.name}-artifacts"
  s3_key        = "wallet-notifier/latest.zip"
  timeout       = 30
}

resource "aws_iam_role" "notifier" {
  name = "${local.name}-notifier"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}
