# Define target group
resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group-django-app"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ecs_vpc.id 
  target_type = "ip"
}

# Create aws ALB
resource "aws_lb" "my_lb" {
  name               = "my-load-balancer-django-app" 
  load_balancer_type = "application"
  subnets            = [aws_subnet.ecs_subnet_A.id, aws_subnet.ecs_subnet_B.id]  # Update with the subnets from your VPC with an internet gateway attached
  security_groups    = [aws_security_group.lb_sg.id]  # Attach the security group to the load balancer
}

# Define alb listener
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}