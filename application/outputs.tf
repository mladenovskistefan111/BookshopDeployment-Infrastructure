# --- application/outputs.tf ---

output "cluster_name" {
  value = aws_eks_cluster.eks.name
}
