provider "aws" {
    version = "~> 2.0"
    region = "ap-south-1"
}


resource "aws_ecs_service" "my_first_service" {
  name            = "my-first-service"                             # Naming our first service
  cluster         = "arn:aws:ecs:ap-south-1:156927083468:cluster/docker_ecr_cluster"            # Referencing our created Cluster
  task_definition = "deployment_task" # Referencing the task our service will spin up
  launch_type     = "FARGATE"
  desired_count   = 3 # Setting the number of containers we want deployed to 3

  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}", "${aws_default_subnet.default_subnet_c.id}"]
    assign_public_ip = true # Providing our containers with public IPs
  }
}