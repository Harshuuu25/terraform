provider "aws" {
    region = "eu-north-1"
}

resource "aws_iam_user" "myboot" {
    name = "harry"
}

resource "aws_iam_policy" "custompolicy" {
    name        = "glacier.one"

    policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": [
				"glacier:InitiateJob",
				"glacier:AbortMultipartUpload",
				"glacier:CreateVault",
				"glacier:ListTagsForVault",
				"glacier:DeleteVault",
				"glacier:DeleteArchive",
				"glacier:ListParts",
				"glacier:DeleteVaultNotifications",
				"glacier:ListJobs",
				"glacier:ListMultipartUploads",
				"glacier:SetVaultNotifications",
				"glacier:CompleteMultipartUpload",
				"glacier:InitiateMultipartUpload",
				"glacier:UploadMultipartPart",
				"glacier:PurchaseProvisionedCapacity",
				"glacier:UploadArchive",
				"glacier:ListVaults",
				"glacier:ListProvisionedCapacity"
			],
			"Resource": "*"
		}
	]
}
    EOF
}

resource "aws_iam_policy_attachment" "policyBind" {
    name = "attachment"
    users = [aws_iam_user.myboot.name]
    policy_arn = aws_iam_policy.custompolicy.arn
}