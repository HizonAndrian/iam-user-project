resource "aws_iam_group" "grp_name" {
  name = "engineer_group"
}

resource "aws_iam_group_policy_attachment" "grp_policy" {
  for_each   = var.policy_map
  group      = aws_iam_group.grp_name.name
  policy_arn = each.value
}

resource "aws_iam_user_group_membership" "grp_member" {
  user = aws_iam_user.users["Andrian"].name

  groups = [
    aws_iam_group.grp_name.name,
  ]
}