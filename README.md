This module configures query logging on an existing Route53 hosted zone.
**NOTE: AWS only supports sending Route53 logs in us-east-1 so we must create all the resources in that region.**
In order to use this module, you will need to define a `us-east-1` provider using the following code:

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
  source  = "trussworks/route53-query-logs/aws"
  version = "~> 2.0.0"

  providers = {
    aws.us-east-1 = aws.us-east-1
  }

  logs_cloudwatch_retention = 30
  zone_id                   = aws_route53_zone.my_zone.zone_id
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| logs\_cloudwatch\_retention | Specifies the number of days you want to retain log events in the log group. | string | `"90"` | no |
| zone\_id | Route53 zone ID. | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
