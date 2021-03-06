resource "aws_route53_zone" "my_zone" {
  name = var.zone_id
}

data "aws_iam_policy_document" "test" {
  count = var.create_resource_policy ? 0 : 1
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

resource "aws_cloudwatch_log_resource_policy" "test" {
  count           = var.create_resource_policy ? 0 : 1
  provider        = aws.us-east-1
  policy_document = data.aws_iam_policy_document.test[0].json
  policy_name     = "route53-query-logging-policy-${var.zone_id}-test"
}

module "r53_query_logging" {
  source = "../.."

  providers = {
    aws.us-east-1 = aws.us-east-1
  }

  logs_cloudwatch_retention = 30
  zone_id                   = aws_route53_zone.my_zone.zone_id
  create_resource_policy    = var.create_resource_policy
}
