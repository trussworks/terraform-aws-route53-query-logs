variable "zone_id" {
  type = string
}

variable "logs_cloudwatch_retention" {
  type    = string
  default = "90"
}

variable "create_resource_policy" {
  type    = bool
  default = true
}
