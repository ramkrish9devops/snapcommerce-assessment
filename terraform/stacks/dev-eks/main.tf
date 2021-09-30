terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.53.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.4.1"
    }
  }
  backend "s3" {
    bucket         = "snapcommerce-assessment-backend"
    key            = "dev/terraform.tfstate"
    region         = "ca-central-1"
    dynamodb_table = "snapcommerce-assessment-backend"
    access_key     = "AKIAZ5LNTJ3XHW2FNZ5K"
    secret_key     = "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"
  }
}

provider "aws" {
  region     = "ca-central-1"
  access_key = "AKIAZ5LNTJ3XHW2FNZ5K"
  secret_key = "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"
}


module "dev-vpc" {
  source = "../../terraform-modules/aws-vpc/"

  name = "dev-vpc"
  cidr = "172.18.0.0/16"

  azs             = ["ca-central-1a", "ca-central-1b"]
  private_subnets = ["172.18.1.0/24", "172.18.2.0/24"]
  public_subnets  = ["172.18.4.0/24", "172.18.5.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  public_subnet_tags = {
    "kubernetes.io/cluster/dev-cluster" = "owned"
    "kubernetes.io/role/elb" = 1
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/dev-cluster" = "owned"
    "kubernetes.io/role/internal-elb" = 1
  }
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.dev-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.dev-cluster.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

module "dev-cluster" {
  source                         = "../../terraform-modules/aws-eks/"
  cluster_name                   = "dev-cluster"
  cluster_version                = "1.19"
  subnets                        = module.dev-vpc.private_subnets
  vpc_id                         = module.dev-vpc.vpc_id
  cluster_endpoint_public_access = true
  cluster_create_timeout         = "45m"
  enable_irsa = true
  manage_aws_auth = true

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 50
  }

  node_groups = {
    dev-ng = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      k8s_labels = {
        Environment = "dev"
      }
    }
  }
}
