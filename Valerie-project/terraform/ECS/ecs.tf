
# read mysql username secret
data "aws_secretsmanager_secret" "mysql_username" {
  name = "mysql_username"
}

data "aws_secretsmanager_secret_version" "mysql_username" {
  secret_id = data.aws_secretsmanager_secret.mysql_username.id
}

# read mysql password secret
data "aws_secretsmanager_secret" "mysql_password" {
  name = "mysql_password"
}
data "aws_secretsmanager_secret_version" "mysql_password" {
  secret_id = data.aws_secretsmanager_secret.mysql_password.id
}

# read mysql url secret
data "aws_secretsmanager_secret" "mysql_url" {
  name = "mysql_url"
}

data "aws_secretsmanager_secret_version" "mysql_url" {
  secret_id = data.aws_secretsmanager_secret.mysql_url.id
}

# read mysql db name secret
data "aws_secretsmanager_secret" "db_name" {
  name = "db_name"
}

data "aws_secretsmanager_secret_version" "db_name" {
  secret_id = data.aws_secretsmanager_secret.db_name.id
}

resource "aws_ecs_task_definition" "django-app" {
  family                   = "django-app-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048

  container_definitions = <<DEFINITION
[
  {
    "image": "${var.container_image}",
    "cpu": 450,
    "memory": 512,
    "name": "${var.container_name}",
    "command": ["/bin/sh", "-c", "./entrypoint.sh"],
    "healthCheck": {
      "retries": 10,
      "command": ["/bin/sh", "-c", "curl -f http://localhost/ht/ || exit 1" ],
      "timeout": 5,
      "interval": 10
    },
    "networkMode": "awsvpc",
    "essential": true,
    "environment": [
        {
          "name": "db_user",
          "value": "${data.aws_secretsmanager_secret_version.mysql_username.secret_string}"
        },
        {
          "name": "db_pass",
          "value": "${data.aws_secretsmanager_secret_version.mysql_password.secret_string}"
        },
        {
          "name": "db_host",
          "value": "${data.aws_secretsmanager_secret_version.mysql_url.secret_string}"
        },
        {
          "name": "db_name",
          "value": "${data.aws_secretsmanager_secret_version.db_name.secret_string}"
        }
    ],
    "portMappings": [
      {
        "containerPort": ${var.container_port},
        "hostPort": ${var.container_port}
      }
    ]
  }
]
DEFINITION
}

resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}

resource "aws_ecs_service" "django-app" {
  name            = var.cluster_service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.django-app.arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type
  force_new_deployment = true

  network_configuration {
    security_groups = [aws_security_group.ecs_sg.id]  
    subnets         = [aws_subnet.ecs_subnet_A.id, aws_subnet.ecs_subnet_B.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  depends_on = [aws_lb_listener.my_listener]
}