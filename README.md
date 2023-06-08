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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_aws.us-east-1"></a> [aws.us-east-1](#provider\_aws.us-east-1) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_resource_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_route53_query_log.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_query_log) | resource |
| [aws_iam_policy_document.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_resource_policy"></a> [create\_resource\_policy](#input\_create\_resource\_policy) | Specifies whether the module should create the resource policy. | `bool` | `true` | no |
| <a name="input_logs_cloudwatch_retention"></a> [logs\_cloudwatch\_retention](#input\_logs\_cloudwatch\_retention) | Specifies the number of days you want to retain log events in the log group. | `string` | `90` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Route53 zone ID. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
