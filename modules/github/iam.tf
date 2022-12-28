data "tls_certificate" "cert" {
  url = "https://${var.oidc_url}"
}

resource "aws_iam_openid_connect_provider" "oidc" {
  url             = "https://${var.oidc_url}"
  client_id_list  = [var.oidc_auditory]
  thumbprint_list = data.tls_certificate.cert.certificates[*].sha1_fingerprint
}

resource "aws_iam_role" "this" {
  name_prefix = "${var.name}-"

  dynamic "inline_policy" {
    for_each = var.attach_policy ? [0] : []
    content {
      name   = "${var.name}_InlinePolicy"
      policy = var.policy
    }
  }

  assume_role_policy = data.aws_iam_policy_document.trust.json
}

data "aws_iam_policy_document" "trust" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    sid     = "GithubOIDCAccess"

    principals {
      identifiers = [aws_iam_openid_connect_provider.oidc.arn]
      type        = "Federated"
    }
    condition {
      test     = "StringEquals"
      variable = "${var.oidc_url}:aud"
      values   = [var.oidc_auditory]
    }
    condition {
      test     = "StringLike"
      variable = "${var.oidc_url}:sub"
      values   = ["repo:${var.owner}/${var.repos}:*"]
    }
  }
}

resource "aws_iam_policy_attachment" "additional" {
  for_each   = toset(var.policy_arns)
  name       = "${aws_iam_role.this.id}"
  roles      = [aws_iam_role.this.name]
  policy_arn = each.value
}
