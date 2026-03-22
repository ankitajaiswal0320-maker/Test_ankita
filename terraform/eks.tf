module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = "devops-eks-cluster"
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access = true

  enable_irsa = true

  self_managed_node_groups = {
    workers = {
      name = "self-managed-workers"

      instance_type = "t3.micro"

      min_size     = 1
      max_size     = 20
      desired_size = 8

      bootstrap_extra_args = ""

      tags = {
        Name = "self-managed-node"
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}