# ============================================
# modules/storage/main.tf — Volúmenes Docker
# ============================================

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_volume" "postgres_data" {
  name = "${var.project_name}-${var.environment}-postgres-data"

  labels {
    label = "project"
    value = var.project_name
  }

  labels {
    label = "environment"
    value = var.environment
  }
}
