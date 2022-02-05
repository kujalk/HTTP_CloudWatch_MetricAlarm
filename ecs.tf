resource "aws_ecs_cluster" "cluster" {
  name               = "${var.Project_Name}_ECS_Cluster"
  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 0
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_task_definition" "task-1" {
  family                   = "${var.Project_Name}_Web"
  container_definitions    = file(var.Container_Definition)
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_role.arn
  requires_compatibilities = ["FARGATE"]
}

resource "aws_ecs_service" "service1" {
  name            = "${var.Project_Name}_Service1"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task-1.arn
  desired_count   = 1
  launch_type     = "FARGATE"


  network_configuration {
    subnets          = [aws_subnet.public1.id]
    security_groups  = [aws_security_group.ecs-service1.id]
    assign_public_ip = true
  }
}