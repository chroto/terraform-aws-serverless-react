variable "name" {
  type        = "string"
  description = "The name for the application"
}

variable "logging_config" {
  type        = "list"
  default     = []
  description = "List of config maps to describe the CloudFront logging configuration"
}

variable "min_ttl" {
  default     = 0
  description = "The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated."
}

variable "default_ttl" {
  default     = 3600
  description = "The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request"
}

variable "max_ttl" {
  default     = 86400
  description = "The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated."
}

variable "error_caching_min_ttl" {
  default     = 60
  description = "he minimum amount of time you want HTTP error codes to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated."
}

variable "environment" {
  default     = "development"
  description = "Tag the resources with an environment. Default is `development`"
}

variable "price_class" {
  default     = "PriceClass_100"
  description = "Set the price class for the CloudFront distribution"
}
