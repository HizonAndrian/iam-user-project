resource "aws_iam_user" "users" {
  for_each = var.iam_users
  name     = each.key
  path     = each.value.path


  tags = {
    CreatedBy = "Terraform"
    Path      = each.value.path
  }
}

resource "aws_iam_user_policy_attachment" "policy_attachment" {
  for_each = local.map_user_policy

  user       = each.value.user
  policy_arn = "arn:aws:iam::aws:policy/${each.value.policy}"
}

resource "aws_iam_access_key" "access_keys" {
  for_each = var.iam_users
  user     = each.key
}

resource "aws_iam_user_policy" "iam_policy" {
  for_each = local.compiled_permission

  name = each.key
  user = each.key

  policy = jsonencode({
    Statement = [
      {
        Action   = "${each.value}"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}