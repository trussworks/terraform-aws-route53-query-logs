<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Configures query logging on an existing Route53 hosted zones
**NOTE: AWS only supports sending Route53 logs in us-east-1 so we must create all the resources in that region.**
Define a us-east-1 provider

```hcl
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}
```

Creates the following resources:

* CloudWatch log group for storing Route53 query logs
* IAM Policy for allowing logs to be written
* Route53 query logging service

## Usage

```hcl
module "r53_query_logging" {
  source = "../../modules/aws-r53-query-logging"

  logs_cloudwatch_retention = 30
  zone_id                   = "Z1234567890"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| logs\_cloudwatch\_retention | Specifies the number of days you want to retain log events in the log group. | string | `"90"` | no |
| zone\_id | Route53 zone ID. | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
