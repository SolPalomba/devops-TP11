# ============================================
# variables.tf — Declaración de variables
# ============================================

variable "environment" {
  description = "Entorno de deployment (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El entorno debe ser dev, staging o prod."
  }
}

variable "project_name" {
  description = "Nombre del proyecto (prefijo para todos los recursos)"
  type        = string
  default     = "devops-portfolio"
}

variable "postgres_image" {
  description = "Imagen de Postgres"
  type        = string
  default     = "postgres:16-alpine"
}

variable "postgres_password" {
  description = "Contraseña de Postgres"
  type        = string
  sensitive   = true
  default     = "devops123"
}

variable "postgres_db" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "notesdb"
}

variable "backend_image" {
  description = "Imagen del backend Flask"
  type        = string
  default     = "solpalomba/devops-portfolio:latest"
}

variable "frontend_image" {
  description = "Imagen del frontend Nginx"
  type        = string
  default     = "solpalomba/devops-frontend:latest"
}

variable "frontend_port" {
  description = "Puerto externo del frontend"
  type        = number
  default     = 8080
}
