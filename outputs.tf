output "cloudfront_id" {
  description = "The ID of the CloudFront distribution fronting the application"
  value       = "${aws_cloudfront_distribution.this.id}"
}

output "s3_bucket_id" {
  description = "The ID of the S3 Bucket hosting the application"
  value       = "${aws_s3_bucket.this.id}"
}

output "domain_name" {
    description = "The CloudFront domain name"
    value       = "${aws_cloudfront_distribution.this.domain_name}"
}
