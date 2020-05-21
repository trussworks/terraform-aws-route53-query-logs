variable "zone_id" {
  type = string
}

variable "logs_cloudwatch_retention" {
  type    = string
  default = "90"
}

variable "enable_resource_policy" {
  type    = bool
  default = true
}
