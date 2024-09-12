# --- root/variables.tf

variable "vpc_cidr" {}
variable "vpc_name" {}
variable "public_subnets" {}
variable "private_appsubnets" {}
variable "private_dbsubnets" {}

variable "ssh_public_key" {
  description = "SSH public key for Bastion host"
  type        = string
}
variable "instance_type" {}

variable "db_instance_count" {}
variable "db_storage" {}
variable "engine" {}
variable "db_engine_version" {}
variable "db_instance_class" {}
variable "db_identifier" {}


variable "cluster_name" {}



