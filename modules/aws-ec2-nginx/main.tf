data "aws_ami" "this" {
  most_recent = true

  filter {
    name = "description"
    values = ["Amazon Linux AMI * x86_64 ECS HVM GP2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["amazon"]
}

data "template_file" "this" {
  template = "${file("${path.module}/files/ec2_nginx_userdata.sh")}"

  vars {
    nginx_listen_port  = "${var.nginx_listen_port}"
    es_endpoint       = "${var.es_endpoint}"
  }
}

data "aws_subnet" "this" {
  id = "${var.subnet_id}"
}


module "this" {
    source                  = "git::ssh://git@gitlab.aws.latitudefs.com/phoenix/TerraformModules.git//aws-instance?ref=master"
    ami                     = "${data.aws_ami.this.image_id}"
    user_data               = "${data.template_file.this.rendered}"
    iam_instance_profile    = "${aws_iam_instance_profile.this.name}"
    security_group_id       = "${aws_security_group.this.id}"
    tags                    = "${var.tags}"
    instance_type           = "${var.instance_type}"
    key_pair_auth_id        = "${var.key_pair_auth_id}"
    deploy_subnet_ids       = ["${var.subnet_id}"]
}
