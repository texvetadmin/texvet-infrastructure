# Generic Project Infrastructure Template

Use this project to as a starting point for projects that will be using serverless, AWS, S3, Cloudfront, and Route 53 to host an API, admin, and web application.

## Prerequisites

While this project aims to automate a majority of the infrastructure, there are some manual steps which must be taken prior to executing the plans.

- Install [Terraform](https://www.terraform.io/)
- Install the [AWS CLI](https://aws.amazon.com/cli/)

### AWS Account & Profile

You should have received AWS credentials from the team lead for your project, otherwise a new AWS account needs to be created with the proper IAM policies.
The AWS CLI should be installed and configured on your local machine.

- Create a profile in the credentials file ~/.aws/credentials

  ```bash
    [<YOUR_NAME_FOR_THIS_PROJECT>]
    aws_access_key_id = <YOUR_ACCESS_KEY_ID_FOR_THIS_PROJECT>
    aws_secret_access_key = <YOUR_SECRET_ACCESS_KEY_FOR_THIS_PROJECT>
  ```

- Before executing any commands, make the `<YOUR_NAME_FOR_THIS_PROJECT>` project the default profile for your aws-cli commands

  ```bash
  export AWS_PROFILE=`<YOUR_NAME_FOR_THIS_PROJECT>`
  ```

### AWS Route53, Certificate Manager & S3

Prior to executing the Terraform plan, make sure the following tasks have been completed:

- Route53
  - Create a public hosted zone
    - Ensure that the top-level domain registrar is setup to use the Route53 public hosted zone name servers
- Certificate Manager
  - Request a TLS certificate for the top-level domain for your project
    - Ensure the sub-domains are defined as optional names on the certificate
      - api.mydomainname.io, dev.mydomainname.io, staging.mydomainname.io
    - Use DNS verification and click the button to allow automatic creation of the DNS records in Route53
- S3
  - Create a bucket named `mydomainname-terraform` in S3 to use as the Terraform backend state storage
  - Turn on bucket versioning

----

## Configure Environments

- Set the variables for each environment:
  - variables-dev.tfvars
  - variables-demo.tfvars
  - variables-staging.tfvars
  - variables-prod.tfvars
- Initialize the Terraform backend in S3
  - `terraform init`
- Create the Terraform workspaces (dev uses the default workspace)
  - `terraform workspace new demo`
  - `terraform workspace new staging`
  - `terraform workspace new prod`

----

## Apply the Configuration

The configuration will be applied to the environments via CircleCI. If you are developing new changes, use the following commands against the development environment to test your changes.

- terraform plan -var-file=variables-dev.tfvars