provider "aws" {
    version = "~> 2.0"
    region = "ap-south-1"
}

resource "aws_ecr_repository" "doker_ecr_repo" {
    name = "docker_ecr_repo"
}

resource "aws_ecr_repository_policy" "demo-repo-policy" {
  repository = aws_ecr_repository.docker_ecr_repo
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the demo repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}

module "ecr_mirror" {
    source = "TechToSpeech/ecr-mirror/aws"
    aws_region = "ap-south-1"
    aws_account_id = var.id
    aws_profile = "default"
    docker_source ="rishabhprashr/tmdb"
    ecr_repo_name ="docker_ecr_repo"
    ecr_repo_tag ="base"
}

    
variable "id" {
    type = string
}
