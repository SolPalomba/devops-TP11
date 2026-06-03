output "postgres_container_name" {
  value = docker_container.postgres.name
}

output "frontend_container_name" {
  value = docker_container.frontend.name
}

output "frontend_url" {
  value = "http://localhost:${var.frontend_port}"
}
