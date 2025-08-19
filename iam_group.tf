#Create a IAM Group called engineer_group.
resource "aws_iam_group" "engr_group" {
  name = "engineer_group"
}

moved {
  from = aws_iam_group.grp_name
  to = aws_iam_group.engr_group
}

#Attach policy to the group.
resource "aws_iam_group_policy_attachment" "grp_policy" {
  for_each   = var.policy_map
  group      = aws_iam_group.engr_group.name
  policy_arn = each.value
}

#Add user to the group.
resource "aws_iam_user_group_membership" "grp_member" {
  user = aws_iam_user.users["Andrian"].name

  groups = [
    aws_iam_group.engr_group.name,
  ]
}