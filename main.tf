/**
 * This module configures query logging on an existing Route53 hosted zone.
 * **NOTE: AWS only supports sending Route53 logs in us-east-1 so we must create all the resources in that region.**
 * In order to use this module, you will need to define a `us-east-1` provider using the following code:
 *
 * ```hcl
 * provider "aws" {
 *   alias  = "us-east-1"
 *   region = "us-east-1"
 * }
 * ```
 *
 * Creates the following resources:
 *
 * * CloudWatch log group for storing Route53 query logs
 * * IAM Policy for allowing logs to be written
 * * Route53 query logging service
 *
 *
 * ## Usage
 *
 * ```hcl
 * module "r53_query_logging" {
 *   source  = "trussworks/route53-query-logs/aws"
 *   version = "~> 1.0.0"
 *
 *   logs_cloudwatch_retention = 30
 *   zone_id                   = "${aws_route53_zone.my_zone.zone_id}"
 * }
 * ```
 */

data "aws_route53_zone" "main" {
  zone_id = "${var.zone_id}"
}

resource "aws_cloudwatch_log_group" "main" {
  provider = "aws.us-east-1"

  name              = "/aws/route53/${data.aws_route53_zone.main.name}"
  retention_in_days = "${var.logs_cloudwatch_retention}"
}

resource "aws_cloudwatch_log_resource_policy" "main" {
  provider        = "aws.us-east-1"
  policy_document = "${data.aws_iam_policy_document.main.json}"
  policy_name     = "route53-query-logging-policy-${var.zone_id}"
}

data "aws_iam_policy_document" "main" {
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
  depends_on = ["aws_cloudwatch_log_resource_policy.main"]

  cloudwatch_log_group_arn = "${aws_cloudwatch_log_group.main.arn}"
  zone_id                  = "${var.zone_id}"
}
