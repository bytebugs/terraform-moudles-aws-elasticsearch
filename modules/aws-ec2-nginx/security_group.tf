# === create the security group the nginx server
resource "aws_security_group" "this" {
    name            = "ec2-nginx-security-group"
    description     = "Security group for the nginx reverse proxy server"
    vpc_id          = "${data.aws_subnet.this.vpc_id}"
    tags            = "${var.tags}"
}

# Alllow SSH access
resource "aws_security_group_rule" "this_ingress_ssh" {
    type                   = "ingress"
    from_port              = 22
    to_port                = 22
    protocol               = "tcp"
    cidr_blocks            = ["${var.cidr_blocks}"]
    security_group_id      = "${aws_security_group.this.id}"
}

# Allow HTTP access
resource "aws_security_group_rule" "this_ingress_http" {
    type                    = "ingress"
    from_port               = 80
    to_port                 = 80
    protocol                = "tcp"
    cidr_blocks             = ["${var.cidr_blocks}"]
    security_group_id       = "${aws_security_group.this.id}"
}

# Allow HTTPS access
resource "aws_security_group_rule" "this_ingress_https" {
    type                        = "ingress"
    from_port                   = 443
    to_port                     = 443
    protocol                    = "tcp"
    cidr_blocks                 = ["${var.cidr_blocks}"]
    security_group_id           = "${aws_security_group.this.id}"
}

# Allow access to the port used by nginx
resource "aws_security_group_rule" "this_ingress_nginx" {
    type                        = "ingress"
    from_port                   = "${var.nginx_listen_port}"
    to_port                     = "${var.nginx_listen_port}"
    protocol                    = "tcp"
    cidr_blocks                 = ["${var.cidr_blocks}"]
    security_group_id           = "${aws_security_group.this.id}"
}

# TODO: Remove this egress rule once set up complete
resource "aws_security_group_rule" "this_egress_anywhere" {
    type                        = "egress"
    from_port                   = 0
    to_port                     = 0
    protocol                    = -1
    cidr_blocks                 = ["0.0.0.0/0"]
    security_group_id           = "${aws_security_group.this.id}"
}
