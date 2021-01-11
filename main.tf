data "aws_route53_zone" "main" {
  zone_id = var.zone_id
}

resource "aws_cloudwatch_log_group" "main" {
  provider = aws.us-east-1

  name              = "/aws/route53/${data.aws_route53_zone.main.name}."
  retention_in_days = var.logs_cloudwatch_retention
}

resource "aws_cloudwatch_log_resource_policy" "main" {
  count           = var.create_resource_policy ? 1 : 0
  provider        = aws.us-east-1
  policy_document = data.aws_iam_policy_document.main[0].json
  policy_name     = "route53-query-logging-policy-${var.zone_id}"
}

data "aws_iam_policy_document" "main" {
  count = var.create_resource_policy ? 1 : 0
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:log-group:/aws/route53/*"]

    principals {
      identifiers = ["route53.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_route53_query_log" "main" {
  cloudwatch_log_group_arn = aws_cloudwatch_log_group.main.arn
  zone_id                  = var.zone_id
}
