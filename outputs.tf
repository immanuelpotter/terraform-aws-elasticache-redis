output "address" {
    value = "${aws_elasticache_cluster.redis.cache_nodes.0.address}"
    description = "DNS name of the instance."
}

output "port" {
    value = "${aws_elasticache_cluster.redis.cache_nodes.0.port}"
    description = "Port the instance is listening on."
}

output "availability_zone" {
    value = "${aws_elasticache_cluster.redis.cache_nodes.0.availability_zone}"
    description = "The availability zone the instance was placed in."
}

output "id" {
    value = "${aws_elasticache_cluster.redis.cache_nodes.0.id}"
    description = "The ID of the instance."
}
