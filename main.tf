resource "aws_elasticache_subnet_group" "redis" {
    name        = "${var.name}"
    description = "Subnets the Redis instances can be place into."
    subnet_ids  = ["${var.subnet_ids}"]
}

resource "aws_elasticache_cluster" "redis" {
    cluster_id               = "${lower( var.name )}"
    engine                   = "redis"
    engine_version           = "${var.engine_version}"
    maintenance_window       = "${var.maintenance_window}"
    node_type                = "${var.node_type}"
    num_cache_nodes          = "1"
    parameter_group_name     = "${var.parameter_group_name}"
    port                     = "6379"
    subnet_group_name        = "${aws_elasticache_subnet_group.redis.name}"
    security_group_ids       = ["${var.security_group_ids}"]
    apply_immediately        = "${var.apply_immediately}"
    snapshot_window          = "${var.snapshot_window}"
    snapshot_retention_limit = "${var.snapshot_retention_limit}"
    availability_zone        = "${var.availability_zone}"

    tags {
        Name        = "${var.name}"
        Project     = "${var.project}"
        Purpose     = "${var.purpose}"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "${var.freetext}"
    }

    lifecycle {
        create_before_destroy = true
    }
}

data "aws_route53_zone" "selected" {
    provider     = "aws.east"
    name         = "${var.domain_name}."
    private_zone = false
}

resource "aws_route53_record" "redis" {
    zone_id = "${data.aws_route53_zone.selected.zone_id}"
    name    = "${var.host_name}.${var.domain_name}"
    type    = "CNAME"
    ttl     = "300"
    records = ["${aws_elasticache_cluster.redis.cache_nodes.0.address}"]
}
