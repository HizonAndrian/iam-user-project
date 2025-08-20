resource "aws_iam_user" "users" {
  for_each = var.iam_users
  name     = each.key
  path     = each.value.path


  tags = {
    CreatedBy = "Terraform"
    Path      = each.value.path
  }
}


#Managed
resource "aws_iam_user_policy_attachment" "policy_attachment" {
  for_each = local.map_user_policy

  user       = each.value.user
  policy_arn = "arn:aws:iam::aws:policy/${each.value.policy}"
}

# resource "aws_iam_access_key" "access_keys" {
#   for_each = var.iam_users
#   user     = each.key
# }

#Inline
resource "aws_iam_user_policy" "iam_policy" {
  for_each = local.map_user_permission

  name = "${each.value.user}_${replace(each.value.permission, ":", "_")}"
  user = each.value.user

  policy = jsonencode({
    Statement = [
      {
        Action   = each.value.permission
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}