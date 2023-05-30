output "load_balancer_dns" {
  value       = aws_lb.my_lb.dns_name
  description = "Get The Load Balancer DNS Name"
}
