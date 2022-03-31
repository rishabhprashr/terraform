provider "aws" {
    version = "~> 2.0"
    region = "ap-south-1"
}

resource "aws_ecr_repository" "doker_ecr_repo" {
    name = "doker_ecr_repo"
}