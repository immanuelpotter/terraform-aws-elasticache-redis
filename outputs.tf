output "id" {
    value = "${aws_elasticache_replication_group.redis.id}"
    description = "The ID of the ElastiCache Replication Group."
}

output "primary_endpoint_address" {
    value = "${aws_elasticache_replication_group.redis.primary_endpoint_address}"
    description = "The address of the endpoint for the primary node in the replication group, if the cluster mode is disabled."
}

output "fqdn" {
    value = "${aws_route53_record.redis.fqdn}"
    description = "Primary DNS name based on the custom domain name."
}
