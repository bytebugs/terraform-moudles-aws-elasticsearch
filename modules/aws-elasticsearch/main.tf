
# Create an AWS Elasticsearch domain

resource "aws_elasticsearch_domain" "this" {
    domain_name           = "${var.es_domain_name}-es"
    elasticsearch_version = "${var.es_version}"

    cluster_config {
        instance_type = "${var.es_instance_type}"
        instance_count = "${var.es_instance_count}"
        dedicated_master_enabled = false
        zone_awareness_enabled = false
    }

    ebs_options {
        ebs_enabled = "true"
        volume_type = "standard"
        volume_size = "${var.es_ebs_volume_size}"
    }

    access_policies = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:*",
      "Condition": {
        "IpAddress": {
            "aws:SourceIp": [
             "${var.es_source_ip_list}"
          ]
        }
      }
    }
  ]
}
CONFIG

    snapshot_options {
        automated_snapshot_start_hour = "${var.es_automated_snapshot_start_hour}"
    }

    tags = "${var.es_tags}"

    # Below is a workaround to avoid reapplying access policy on every run
    # Please refer to: https://github.com/hashicorp/terraform/issues/3634
    lifecycle {
      ignore_changes = [
          "access_policies"
      ]
    }
}
