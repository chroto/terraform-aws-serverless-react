AWS Serverless React Terraform module
================================================

Terraform module which creates S3, CloudFront, and Route53 resources for
hosting a React application.

These types of resources are supported:

* [CloudFront Distribution](https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html)
* [S3 Bucket](https://www.terraform.io/docs/providers/aws/r/s3_bucket.html)
* [Route53 Record](https://www.terraform.io/docs/providers/aws/r/elb_attachment.html)


Usage
-----

```hcl
module "my-app" {
  source = "terraform-aws-modules/serverless-react/aws"
  name = "my-app"
```

Examples
--------


Known Issues/Limitations
------------------------

Authors
-------

Module managed by [Chris Proto](https://github.com/chroto).

License
-------

Apache 2 Licensed. See LICENSE for full details.
