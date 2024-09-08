# --- application/main.tf ---

resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn  = aws_iam_role.eks_role.arn
  version   = "1.30"  # Specify the version of Kubernetes you want

  vpc_config {
    subnet_ids = var.private_appsubnets
  }

  tags = {
    Name = var.cluster_name
  }
}