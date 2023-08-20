terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.10.0"
    }
  }

  backend "s3" {
    bucket         = "tfremotestate-ec2"
    key            = "state"
    region         = "eu-central-1"
    dynamodb_table = "tfremotestate-ec2"
  }
}
