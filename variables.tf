# === Elasticsearch configuration
variable "es_domain_name" {
  description = "Name of the domain."
}

variable "es_source_ip_list" {
  description = "Public IPs that can access the Elasticsearch cluster"
}


# === nginx reverse proxy server configuration
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
