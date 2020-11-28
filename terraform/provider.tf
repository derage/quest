terraform {
  backend "s3" {
    bucket = "jcaf-quest"
    region = "us-east-1"
    key = "quest"
  }
}

provider "aws" {
  region = "us-east-1"
}