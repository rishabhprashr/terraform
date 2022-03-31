provider "aws" {
    version = "~> 2.0"
    region = "ap-south-1"
}

resource "aws_ecs_cluster" "doker_ecr_cluster" {
    name = "doker_ecr_cluster"
}