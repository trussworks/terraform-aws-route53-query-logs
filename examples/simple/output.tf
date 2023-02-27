output "route53_zone_id" {
  value       = aws_route53_zone.my_zone.zone_id
  description = "The Zone ID for the Route53 Zone."
}
