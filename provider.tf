terraform {
  backend "s3" {
    bucket       = "ivan-tfstate"
    key          = "test.tfstate"
    region       = "eu-north-1"
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
