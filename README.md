AWS Serverless React Terraform module
================================================

Terraform module which creates S3 and CloudFront resources for hosting a React
application.

These types of resources are supported:

* [CloudFront Distribution](https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html)
* [S3 Bucket](https://www.terraform.io/docs/providers/aws/r/s3_bucket.html)


Usage
-----

```hcl
module "my-app" {
  source = "chroto/serverless-react/aws"
  name = "my-app"
```

Examples
--------


Known Issues/Limitations
------------------------
* CloudFront restrictions can not be configured
* Custom aliases and domain names are unavailable
* Custom SSL Certificates are not supported

Authors
-------

Module managed by [Chris Proto](https://github.com/chroto).

License
-------

Apache 2 Licensed. See LICENSE for full details.
