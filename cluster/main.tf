provider "aws" {
    version = "~> 2.0"
    region = "ap-south-1"
}

resource "aws_ecs_cluster" "docker_ecr_cluster" {
    name = "docker_ecr_cluster"
}