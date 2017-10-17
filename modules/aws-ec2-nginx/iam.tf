# === create an instance profile for the nginx server
resource "aws_iam_role" "this" {
    name_prefix        = "ec2-nginx-role"
    description        = "Allows nginx instance to assume required roles"
    assume_role_policy = "${file("${path.module}/files/ec2_nginx_iam_role_trust.json")}"
}

resource "aws_iam_instance_profile" "this" {
    name_prefix = "ec2-nginx-instance-profile"
    role        = "${aws_iam_role.this.name}"
}

resource "aws_iam_role_policy" "this" {
    name_prefix = "ec2-nginx-role-policy"
    role        = "${aws_iam_role.this.id}"
    policy      = "${file("${path.module}/files/ec2_nginx_iam_role_policy.json")}"
}
