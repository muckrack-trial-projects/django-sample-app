output "rds_endpoint" {
  value = split(":", aws_db_instance.mysql_instance.endpoint)[0]
}