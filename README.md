This module configures query logging on an existing Route53 hosted zone.

**NOTE: AWS only supports sending Route53 logs in us-east-1 so we must create all the resources in that region.**

In order to use this module, you will need to define a `us-east-1` provider using the following code:

```hcl
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}
```

**ADDITIONAL NOTE: There is a limit of ten Cloudwatch log resource policies an AWS account can have in place. If you plan to have several instances of this module, it is recommended that only one should have `create_resource_policy` set to true and the others to false.**

Creates the following resources:

- CloudWatch log group for storing Route53 query logs
- IAM Policy for allowing logs to be written
- Route53 query logging service

## Usage

```hcl
module "r53_query_logging" {
  source  = "trussworks/route53-query-logs/aws"
  version = "~> 3.0.0"

  providers = {
    aws.us-east-1 = aws.us-east-1
  }

  logs_cloudwatch_retention = 30
  zone_id                   = aws_route53_zone.my_zone.zone_id
}
```

## Terraform Versions

- Terraform 0.13 and newer. Pin module version to ~> 3.0. Submit pull requests to `master` branch.
- Terraform 0.12. Pin module version to ~> 2.0. Submit pull requests to `terraform012` branch.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0 |
| aws.us-east-1 | >= 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_resource\_policy | Specifies whether the module should create the resource policy. | `bool` | `true` | no |
| logs\_cloudwatch\_retention | Specifies the number of days you want to retain log events in the log group. | `string` | `90` | no |
| zone\_id | Route53 zone ID. | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
