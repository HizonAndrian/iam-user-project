resource "aws_iam_access_key" "users_access_key" {
  for_each = var.iam_users

  user = each.key
}

resource "aws_secretsmanager_secret" "iam_user_keys" {
  for_each = var.iam_users

  name = "${each.key}_access_keys"
}


resource "aws_secretsmanager_secret_version" "secret_version" {
  for_each = var.iam_users

  secret_id = aws_secretsmanager_secret.iam_user_keys[each.key].id
  secret_string = jsonencode({
    access_key_id     = aws_iam_access_key.users_access_key[each.key].id
    secret_access_key = aws_iam_access_key.users_access_key[each.key].secret
  })
}

# output "access_keys" {

#   sensitive = true
#   value = [for key in keys(var.iam_users) : {
#     username          = key
#     access_key_id     = aws_iam_access_key.users_access_key[key].id
#     secret_access_key = aws_iam_access_key.users_access_key[key].secret
#   }]
# }