resource "aws_route53_zone" "my_zone" {
  name = var.zone_id

}
module "r53_query_logging" {
  source = "../.."

  providers = {
    aws.us-east-1 = aws.us-east-1
  }

  logs_cloudwatch_retention = 30
  zone_id                   = aws_route53_zone.my_zone.zone_id
}