output "bucket_name" {
  description = "S3 bucket name for uploading the React production build."
  value       = aws_s3_bucket.frontend.id
}

output "cloudfront_domain_name" {
  description = "Public CloudFront HTTPS URL for the React frontend."
  value       = aws_cloudfront_distribution.frontend.domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront Distribution ID for cache invalidation."
  value       = aws_cloudfront_distribution.frontend.id
}
