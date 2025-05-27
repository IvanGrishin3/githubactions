module "github-oidc" {
  source  = "terraform-module/github-oidc-provider/aws"
  version = "2.2.0"

  create_oidc_provider = true
  create_oidc_role     = false

  repositories = ["IvanGrishin3/githubactions"]
}

data "aws_iam_policy_document" "github_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::093591452678:oidc-provider/token.actions.githubusercontent.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:IvanGrishin3/githubactions:*"]
    }
  }
}

resource "aws_iam_role" "test_role" {
  name               = "test_role"
  assume_role_policy = data.aws_iam_policy_document.github_policy.json
}

resource "aws_iam_role_policy_attachment" "test_role_attach" {
  role       = aws_iam_role.test_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
