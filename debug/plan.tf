terraform {
    required_version = ">= 0.11.1"
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
    freetext                         = "No notes at this time."
    security_group_ids               = ["sg-566f7a2a"]
    subnet_ids                       = ["subnet-568ee830","subnet-4a33b402","subnet-ac5f72f7"]
    snapshot_window                  = ""
    snapshot_retention_limit         = "0"
}

output "address" {
    value = "${module.redis.address}"
}

output "port" {
    value = "${module.redis.port}"
}

output "availability_zone" {
    value = "${module.redis.availability_zone}"
}

output "id" {
    value = "${module.redis.id}"
}
