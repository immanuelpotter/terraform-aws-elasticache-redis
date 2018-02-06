terraform {
    required_version = ">= 0.11.3"
    backend "s3" {}
}

provider "aws" {
    region     = "${var.region}"
}

provider "aws" {
    alias = "east"
    region = "us-east-1"
}

resource "aws_elasticache_subnet_group" "redis" {
    name        = "${var.name}"
    description = "Subnets the Redis instances can be place into."
    subnet_ids  = ["${var.subnet_ids}"]
}

resource "aws_elasticache_replication_group" "redis" {
    replication_group_id          = "${lower( var.name )}"
    replication_group_description = "${var.purpose}"
    number_cache_clusters         = "${var.number_cache_clusters}"
    node_type                     = "${var.node_type}"
    automatic_failover_enabled    = "${var.automatic_failover_enabled}"
    auto_minor_version_upgrade    = "${var.auto_minor_version_upgrade}"
    engine                        = "redis"
    at_rest_encryption_enabled    = "${var.at_rest_encryption_enabled}"
    transit_encryption_enabled    = "${var.transit_encryption_enabled}"
    auth_token                    = "${var.auth_token}"
    engine_version                = "${var.engine_version}"
    parameter_group_name          = "${var.parameter_group_name}"
    port                          = "6379"
    subnet_group_name             = "${aws_elasticache_subnet_group.redis.name}"
    security_group_ids            = ["${var.security_group_ids}"]
    maintenance_window            = "${var.maintenance_window}"
    notification_topic_arn        = "${var.notification_topic_arn}"
    snapshot_window               = "${var.snapshot_window}"
    snapshot_retention_limit      = "${var.snapshot_retention_limit}"
    apply_immediately             = "${var.apply_immediately}"

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
    records = ["${aws_elasticache_replication_group.redis.primary_endpoint_address}"]
}
