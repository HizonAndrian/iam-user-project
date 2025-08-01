locals {
  flatten_user_policy = flatten([
    for user_key, user_value in var.iam_users : [
        for policy in user_value.policy : {
            user = user_key
            policy = policy
        }
    ]
  ])
}

locals {
  map_user_policy = {
    for item in local.flatten_user_policy :
    "${item.user}-${item.policy}" => item
  }
}

output "test" {
  value = local.map_user_policy
}