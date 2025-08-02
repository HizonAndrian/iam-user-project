#This one local created a list from our var.iam_users
locals {
  flatten_user_policy = flatten([
    for user_key, user_value in var.iam_users : [
      for policy in user_value.policy : {
        user   = user_key
        policy = policy
      }
    ]
  ])
}

#Created a flatten map
locals {
  map_user_policy = {
    for item in local.flatten_user_policy :
    "${item.user}-${item.policy}" => item
  }
}

locals {
  compiled_permission = {
    for user_key, user_value in var.iam_users :
    user_key => user_value.permission
  }
}


output "display" {
  value = local.compiled_permission
}