resource "aws_route53_zone" "my_zone" {
  name = var.zone_id
}

resource "aws_cloudwatch_log_resource_policy" "main" {
  provider        = aws.us-east-1
  policy_document = data.aws_iam_policy_document.main.json
  policy_name     = "route53-query-logging-policy-${var.zone_id}"
}

module "r53_query_logging" {
  source = "../.."

  providers = {
    aws.us-east-1 = aws.us-east-1
  }

  logs_cloudwatch_retention = 30
  zone_id                   = aws_route53_zone.my_zone.zone_id
  enable_resource_policy    = var.enable_resource_policy
}
