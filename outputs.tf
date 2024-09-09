# --- root/outputs.tf ---

output "rds_endpoint" {
  value = module.database.rds_endpoint
}

output "bastion_host_ip" {
  value = module.bastion.bastion_host_ip
}