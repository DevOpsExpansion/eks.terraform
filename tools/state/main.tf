module "state_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.6.0"

  bucket = "terraform-${data.aws_caller_identity.this.account_id}"

  attach_public_policy = false

  # These parameters are equivalent to the checkbox "block all public access"
  block_public_policy     = true
  block_public_acls       = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  attach_policy = true
  policy        = data.aws_iam_policy_document.policy.json

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


# Policy restricting access to the bucket only for the user used for terraform
data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [module.state_bucket.s3_bucket_arn]

    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.this.arn]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = ["${module.state_bucket.s3_bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.this.arn]
    }
  }
}

data "aws_caller_identity" "this" {}
