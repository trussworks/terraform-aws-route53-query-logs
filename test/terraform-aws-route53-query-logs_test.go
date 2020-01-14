package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/require"
)

func TestTerraformRoute53QueryLog(t *testing.T) {
	t.Parallel()

	tempTestFolder := test_structure.CopyTerraformFolderToTemp(t, "../", "examples/simple")

	// Give this Route53 Zone a unique ID for a name tag so we can distinguish it from any other zones provisioned
	// in your AWS account
	testName := fmt.Sprintf("terratest-aws-route53-query-logs-%s", strings.ToLower(random.UniqueId()))
	logGroupName := fmt.Sprintf("/aws/route53/%s.com.", testName)
	// This _must_ be "us-east-1" unlike our other tests as Route53 query logs are _only_ available in us-east-1.
	awsRegion := "us-east-1"

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: tempTestFolder,

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"logs_cloudwatch_retention": "30",
			"zone_id":                   fmt.Sprintf("%s.com", testName),
		},

		// Environment variables to set when running Terraform
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// This will ensure the log stream is not empty
	require.NotNil(t, aws.GetCloudWatchLogEntries(t, awsRegion, "route53-test-log-stream", logGroupName))
}
