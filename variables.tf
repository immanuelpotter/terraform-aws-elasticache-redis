variable "region" {
    type = "string"
    description = "The AWS region to deploy into (e.g. us-east-1)"
}

variable "name" {
    type = "string"
    description = "What to name the resources being created"
}

variable "project" {
    type = "string"
    description = "Name of the project these resources are being created for"
}

variable "purpose" {
    type = "string"
    description = "The role the resources will play"
}

variable "creator" {
    type = "string"
    description = "Person creating these resources"
}

variable "environment" {
    type = "string"
    description = "Context these resources will be used in, e.g. production"
}

variable "freetext" {
    type = "string"
    description = "Information that does not fit in the other tags"
}

variable "engine_version" {
    type = "string"
    description = "The version of Redis to use, e.g. 3.2.10.  If left blank, the latest engine is used."
    default = ""
}

variable "maintenance_window" {
    type = "string"
    description = "The window to perform maintenance in."
    default = "Sun:03:00-Sun:05:00"
}

variable "node_type" {
    type = "string"
    description = "The instance type of the Redis instance, e.g. cache.t2.micro"
    default = "cache.t2.micro"
}

variable "parameter_group_name" {
    type = "string"
    description = "Name of the Redis parameter group to associate to the instance, e.g. default.redis3.2"
    default = ""
}

variable "security_group_ids" {
    type = "list"
    description = "List of VPC security groups to associate to the instance."
}

variable "apply_immediately" {
    type = "string"
    description = "If true, engine upgrades are done immediately, otherwise done during the next maintenance window."
    default = "false"
}

variable "snapshot_window" {
    type = "string"
    description = "The daily time range (in UTC) during which automated backups are created, if enabled."
    default = "00:00-02:00"
}

variable "snapshot_retention_limit" {
    type = "string"
    description = "How many days to retain backups."
    default = "7"
}

variable "availability_zone" {
    type = "string"
    description = "The availability zone to place the instance into."
    default = ""
}

variable "subnet_ids" {
    type = "list"
    description = "List of subnets ids where the instance can live, e.g. [subnet-6412a148,subnet-e18b0185]"
}

variable "domain_name" {
    type = "string"
    description = "Route53 managed domain name to map the instance to, e.g. example.com."
}

variable "host_name" {
    type = "string"
    description = "The host name to use when creating the mapping to your managed domain name, e.g. development-redis."
}
