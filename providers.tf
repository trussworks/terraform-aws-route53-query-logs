# Terraform 0.12 requires providers that aren't implicitly passed into the
# module. Adding "region" will prevent us from being able to remove this
# module.
# See https://github.com/hashicorp/terraform/issues/22907 for details.
provider "aws" {
  alias = "us-east-1"
}
