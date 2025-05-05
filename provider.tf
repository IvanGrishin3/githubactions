terraform {
  backend "s3" {
    bucket       = "osp-terraform-states"
    key          = "test.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.21.0"
    }
  }
  required_version = ">= 1.10.0"
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}
