provider "aws" {
    region  =   "ap-southeast-2"
}

data "aws_subnet" "this" {
  cidr_block = "10.137.82.0/25" #data_dev-sn-application-dev0
}

resource "aws_key_pair" "this" {
    key_name   = "kp_nginx"
    public_key = "${file("./files/kp_nginx.pub")}"
}

module "this" {
    source                  = "./../"
    es_domain_name          = "demo-es-domain"
    es_source_ip_list       = "52.63.11.245"
    key_pair_auth_id        = "${aws_key_pair.this.id}"
    subnet_id               = "${data.aws_subnet.this.id}"
    cidr_blocks             = ["3.0.0.0/8", "10.19.0.0/16"]
}



# === Shared Services Provider for Route53
# provider "aws" {
#   alias  = "shared_prod"
#   region = "ap-southeast-2"
#
#   assume_role {
#     role_arn = "arn:aws:iam::506986483626:role/VPCPeerRoute53"
#   }
# }
#
# # Capture the Private Domain Zone details
# data "aws_route53_zone" "aws_latitudefs_private" {
#   provider     = "aws.shared_prod"
#   name         = "aws.latitudefs.com"
#   private_zone = true
# }
#
# # internal.api-test1.aws.latitudefs.com: Create a record in the Zone
# resource "aws_route53_record" "www_nginx" {
#   provider    = "aws.shared_prod"
#   name        = "nginx.data-np"
#   zone_id     = "${data.aws_route53_zone.aws_latitudefs_private.zone_id}"
#   type        = "A"
#   ttl         = "300"
#   records     = ["${module.this.nginx_instance_private_ip}"]
# }
