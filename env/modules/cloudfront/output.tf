output "distribution_id" {
  value = aws_cloudfront_distribution.main.id
}

output "route53_record_name" {
  value = aws_route53_record.cloudfront.name
}
