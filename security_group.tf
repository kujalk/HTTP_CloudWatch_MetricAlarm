#Security group for ECS - Service1
resource "aws_security_group" "ecs-service1" {
  name        = "${var.Project_Name}_ECS_Service1"
  description = "To allow Traffic to ECS Service 1"
  vpc_id      = aws_vpc.main.id


  tags = {
    Name = "${var.Project_Name}_ECS_Service1"
  }

  ingress {
    description = "HTTP Traffic Allow"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outside"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
