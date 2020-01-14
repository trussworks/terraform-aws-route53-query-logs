variable "logs_cloudwatch_retention" {
  description = "Specifies the number of days you want to retain log events in the log group."
  #  default     = 90
  type = string
}

variable "zone_id" {
  description = "Route53 zone ID."
  type        = string
  default     = ""
}
