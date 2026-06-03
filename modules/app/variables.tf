variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "postgres_image" {
  type = string
}

variable "postgres_password" {
  type      = string
  sensitive = true
}

variable "postgres_db" {
  type = string
}

variable "frontend_image" {
  type = string
}

variable "frontend_port" {
  type = number
}

variable "network_name" {
  type = string
}

variable "postgres_volume_name" {
  type = string
}
