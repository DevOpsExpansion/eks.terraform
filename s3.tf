module "helm_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.6.0"

  bucket = "charts-${data.aws_caller_identity.this.account_id}"

  attach_public_policy = false

  # These parameters are equivalent to the checkbox "block all public access"
  block_public_policy     = true
  block_public_acls       = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      bucket_key_enabled = true
      apply_server_side_encryption_by_default = {
        sse_algorithm = "aws:kms"
      }
    }
  }

  # Reality of life
  putin_khuylo = true
}