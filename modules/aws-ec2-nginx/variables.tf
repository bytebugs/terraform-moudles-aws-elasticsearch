# Defaulted input Variables
variable "tags" {
  type        = "map"
  description = ""
  default     = {}
}

variable "nginx_listen_port" {
  description = ""
  default     = "8082"
}

variable "instance_type" {
  description = ""
  default     = "t2.nano"
}

# required input Variables
variable "key_pair_auth_id" {
  description = ""
}

variable "cidr_blocks" {
  type    = "list"
  description = ""
}

variable "subnet_id" {
  description = ""
}

variable "es_endpoint" {
    description = "Domain-specific endpoint used to submit index, search, and data upload requests."
}
