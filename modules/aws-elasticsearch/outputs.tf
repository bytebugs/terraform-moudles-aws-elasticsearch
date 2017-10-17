# Usable Outputs

output "aws_elasticsearch_domain_arn" {
    description = "Amazon Resource Name (ARN) of the domain."
    value       = "${aws_elasticsearch_domain.this.arn}"
}

output "aws_elasticsearch_domain_domain_id" {
    description = "Unique identifier for the domain."
    value       = "${aws_elasticsearch_domain.this.domain_id}"
}

output "aws_elasticsearch_domain_endpoint" {
    description = "Domain-specific endpoint used to submit index, search, and data upload requests."
    value       = "${aws_elasticsearch_domain.this.endpoint}"
}
