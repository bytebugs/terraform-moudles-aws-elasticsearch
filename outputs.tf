# Usable Outputs
output "elasticsearch_domain_arn" {
    description = "Amazon Resource Name (ARN) of the domain."
    value       = "${module.es.aws_elasticsearch_domain_arn}"
}

output "elasticsearch_domain_domain_id" {
    description = "Unique identifier for the domain."
    value       = "${module.es.aws_elasticsearch_domain_domain_id}"
}

output "elasticsearch_domain_endpoint" {
    description = "Domain-specific endpoint used to submit index, search, and data upload requests."
    value       = "${module.es.aws_elasticsearch_domain_endpoint}"
}

output "nginx_instance_id" {
    value = "${module.nginx.aws_instance_id}"
}

output "nginx_instance_private_dns" {
    value = "${module.nginx.aws_instance_private_dns}"
}

output "nginx_instance_private_ip" {
    value = "${module.nginx.aws_instance_private_ip}"
}
