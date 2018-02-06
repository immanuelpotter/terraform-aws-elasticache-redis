terraform {
    required_version = ">= 0.11.3"
    backend "s3" {}
}

module "redis" {
    source = "../"

    region                           = "us-west-2"
    name                             = "Debug"
    project                          = "Debug"
    purpose                          = "Testing out Terraform module"
    creator                          = "kurron@jvmguy.com"
    environment                      = "development"
    freetext                         = "Master, with one replica."
    security_group_ids               = ["sg-ef8dc992"]
    subnet_ids                       = ["subnet-1ac8b67e","subnet-c524fb9d","subnet-f29c0d84"]
    snapshot_window                  = ""
    snapshot_retention_limit         = "0"
    domain_name                      = "transparent.engineering"
    host_name                        = "debug-redis"
    auth_token                       = "MustBeSixteenCharacters"
    engine_version                   = "3.2.6"
    automatic_failover_enabled       = "false"
}

output "id" {
    value = "${module.redis.id}"
}

output "primary_endpoint_address" {
    value = "${module.redis.primary_endpoint_address}"
}

output "fqdn" {
    value = "${module.redis.fqdn}"
}
