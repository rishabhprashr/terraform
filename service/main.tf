provider "aws" {
    region = "eu-central-1"
}

terraform{
    backend "s3" {
        bucket = "statebucket-sp93019"
        key    = "state/"
        region = "eu-central-1"
    }
}


resource "aws_ecs_service" "deployment_service" {
  name            = "deployment-service"                             # Naming our first service
  cluster         = "${aws_ecs_cluster.docker_ecr_cluster.id}"             # Referencing our created Cluster
  task_definition = "${aws_ecs_task_definition.deployment_task.arn}" # Referencing the task our service will spin up
  launch_type     = "FARGATE"
  desired_count   = 2
  force_new_deployment = true # Setting the number of containers to 3
  depends_on      = [
      aws_lb_listener.listener,
      aws_iam_role_policy_attachment.ecsTaskExecutionRole_policy
      ]
}
