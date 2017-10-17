# get caller identity
data "aws_caller_identity" "current" {
  # no arguments
}


module "es" {
  source                  = "./modules/aws-elasticsearch"
  es_domain_name          = "${var.es_domain_name}"
  es_source_ip_list       = "${var.es_source_ip_list}"
  aws_account_id          = "${data.aws_caller_identity.current.account_id}"
}


module "nginx" {
  source                  = "./modules/aws-ec2-nginx"
  es_endpoint             = "${module.es.aws_elasticsearch_domain_endpoint}"
  key_pair_auth_id        = "${var.key_pair_auth_id}"
  subnet_id               = "${var.subnet_id}"
  cidr_blocks             = ["${var.cidr_blocks}"]
}
