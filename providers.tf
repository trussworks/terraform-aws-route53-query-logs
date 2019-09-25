# Terraform 0.12 requires providers that aren't implicitly passed into the
# module. No "region" or "version" is needed as those will be defined in
# where the module is being instantiated.
provider "aws" {
  alias = "us-east-1"
}
