# --- bastion/variables.tf

variable "vpc_id" {}
# variable "public_key_path" {}
variable "ssh_public_key" {
  description = "SSH public key for Bastion host"
  type        = string
}
variable "instance_type" {}
variable "public_subnet" {}