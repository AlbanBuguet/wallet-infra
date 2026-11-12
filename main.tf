terraform {
  required_version = ">= 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      project     = "opco-a-trip-wallet"
      repo        = "opco-a/wallet-infra"
      environment = var.environment
      owner       = "opco-a/companion"
    }
  }
}

locals {
  name = "opco-a-trip-wallet-${var.environment}"
}
