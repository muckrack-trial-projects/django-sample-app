output "ecr_repository_url" {
  value = aws_ecrpublic_repository.container_repository.repository_uri
}