# --- application/outputs.tf ---

output "app_security_group_id" {
  value = aws_security_group.eks_cluster_security_group.id
}