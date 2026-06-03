# ============================================
# modules/network/main.tf — Redes Docker
# ============================================

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_network" "app_network" {
  name   = "${var.project_name}-${var.environment}-network"
  driver = "bridge"

  labels {
    label = "project"
    value = var.project_name
  }

  labels {
    label = "environment"
    value = var.environment
  }
}
