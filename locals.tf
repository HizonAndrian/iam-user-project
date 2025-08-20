#This local creates a flatten list from our var.iam_users
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

#From list to map, base on locals.flatten_user_policy
#In order to use for_each, we need to use a Map
locals {
  map_user_policy = {
    for item in local.flatten_user_policy :
    "${item.user}-${item.policy}" => item
  }
}

locals {
  flatten_permission = flatten([
    for user_key, user_value in var.iam_users : [
      for permission in user_value.permission : {
        user       = user_key
        permission = permission
      }
    ]
  ])
}

locals {
  map_user_permission = {
    for item in local.flatten_permission :
    "${item.user}-${item.permission}" => item
  }
}

