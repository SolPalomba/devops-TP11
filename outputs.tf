# ============================================
# outputs.tf — Valores de salida
# ============================================

output "frontend_url" {
  description = "URL de acceso al frontend"
  value       = module.app.frontend_url
}

output "postgres_container" {
  description = "Nombre del contenedor de Postgres"
  value       = module.app.postgres_container_name
}

output "frontend_container" {
  description = "Nombre del contenedor del frontend"
  value       = module.app.frontend_container_name
}

output "network_name" {
  description = "Red Docker creada"
  value       = module.network.network_name
}

output "postgres_volume" {
  description = "Volumen de Postgres creado"
  value       = module.storage.postgres_volume_name
}
