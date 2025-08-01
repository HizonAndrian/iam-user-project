# variable "user_tags" {
#   type = map(string)
# }

variable "iam_users" {
  type = map(object({
    path      = string
    policy    = list(string)
    permission = list(string)
  }))
}