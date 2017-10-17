# Default Input Variables

variable "region" {
  description = "AWS region to launch servers."
  default     = "ap-southeast-2"
}

variable "es_tags" {
  type        = "map"
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "es_version" {
  description = "The version of ElasticSearch to deploy."
  default     = "5.5"
}

variable "es_instance_type" {
  description = "Instance type of data nodes in the cluster."
  default     = "t2.small.elasticsearch"
}

variable "es_instance_count" {
  description = "Number of instances in the cluster."
  default       = 3
}

variable "es_ebs_volume_size" {
  description = "The size of EBS volumes attached to data nodes (in GB)."
  default     = 35
}

variable "es_ebs_volume_type" {
  description = "The type of EBS volumes attached to data nodes."
  default     = "gp2"
}

variable "es_automated_snapshot_start_hour" {
  description = "Hour during which the service takes an automated daily snapshot of the indices in the domain."
  default     = 23
}

# Required Input Variables

variable "es_domain_name" {
  description = "Name of the domain."
}

variable "es_source_ip_list" {
  description = "Public IPs that can access the Elasticsearch cluster"
}

variable "aws_account_id" {
  description = "Your aws account number"
}
