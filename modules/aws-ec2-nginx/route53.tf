# === Shared Services Provider for Route53
provider "aws" {
  alias  = "shared_prod"
  region = "ap-southeast-2"

  assume_role {
    role_arn = "${var.vpc_peer_route53_assume_role}"
  }
}

# Capture the Private Domain Zone details
data "aws_route53_zone" "this" {
  provider     = "aws.shared_prod"
  name         = "${var.route53_zone_name}"
  private_zone = true
}

# internal.api-test1.aws.latitudefs.com: Create a record in the Zone
resource "aws_route53_record" "this" {
  provider    = "aws.shared_prod"
  name        = "${var.route53_record_name}"
  zone_id     = "${data.aws_route53_zone.this.zone_id}"
  type        = "${var.route53_record_type}"
  ttl         = "${var.route53_record_ttl}"
  records     = ["${module.this.aws_instance_private_ip}"]
}


variable "vpc_peer_route53_assume_role" {
  description = ""
  default     = "arn:aws:iam::506986483626:role/VPCPeerRoute53"
}

variable "route53_provider" {
  description = ""
  default     = "aws.shared_prod"
}

variable "route53_zone_name" {
  description = ""
  default     = "aws.latitudefs.com"
}

variable "route53_record_name" {
  description = ""
  default     = "nginx.ec2.data-np"
}

variable "route53_record_ttl" {
  description = ""
  default     = 300
}

variable "route53_record_type" {
  description = ""
  default     = "A"
}
