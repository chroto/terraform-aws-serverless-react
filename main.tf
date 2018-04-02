terraform {
  required_version = ">= 0.11.5"
}

#|
#| S3 Bucket Configuration
#|
resource "aws_s3_bucket" "this" {
  bucket = "${var.name}-${var.environment}"

  tags {
    Name        = "${var.name}"
    Environment = "${var.environment}"
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = "${aws_s3_bucket.this.id}"
  policy = "${data.aws_iam_policy_document.s3_policy.json}"
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.this.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.this.iam_arn}"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.this.arn}"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.this.iam_arn}"]
    }
  }
}

#|
#| CloudFront Configuration
#|
resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "ServerlessReact App For ${var.name}"
}

resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = "${aws_s3_bucket.this.bucket_domain_name}"
    origin_id   = "myS3Origin"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path}"
    }
  }

  #| TODO: Add ability to configure restrictions
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "${var.price_class}"
  comment             = "ServerlessReact App for ${var.name}"
  default_root_object = "index.html"

  #| TODO Allow for setting up domain names and aliases
  ## aliases = ["${var.domain_name}"]

  tags {
    Name        = "${var.name}"
    Environment = "${var.environment}"
  }
  logging_config = "${var.logging_config}"
  #| TODO: Allow Option for ACM
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "myS3Origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = "${var.min_ttl}"
    default_ttl            = "${var.default_ttl}"
    max_ttl                = "${var.max_ttl}"
  }
  custom_error_response {
    error_caching_min_ttl = "${var.error_caching_min_ttl}"
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }
  custom_error_response {
    error_caching_min_ttl = "${var.error_caching_min_ttl}"
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
  }
}
