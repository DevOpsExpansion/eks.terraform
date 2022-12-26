module "frontend" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.6.0"

  bucket_prefix = "${var.name}-${var.prefix}-frontend"
  force_destroy = true

  attach_policy = true
  policy        = data.aws_iam_policy_document.frontend.json

  website = {
    index_document = "index.html"
    error_document = "index.html"
  }

  putin_khuylo = true
}

data "aws_iam_policy_document" "frontend" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.frontend.s3_bucket_arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}
