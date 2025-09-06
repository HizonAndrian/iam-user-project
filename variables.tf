variable "iam_users" {
  type = map(object({
    path       = string
    policy     = list(string)
    permission = optional(list(string), [])
  }))
}


variable "policy_map" {
  type = map(string)

  default = {
    Ec2         = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    VPC         = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
    IAMReadOnly = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
  }
}