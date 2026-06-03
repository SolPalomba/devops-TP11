# ============================================
# modules/app/main.tf — Contenedores Docker
# ============================================

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# ── Imágenes ──────────────────────────────────────────────
resource "docker_image" "postgres" {
  name         = var.postgres_image
  keep_locally = true
}

resource "docker_image" "frontend" {
  name         = "nginx:alpine"
  keep_locally = true
}

# ── Contenedor Postgres ───────────────────────────────────
resource "docker_container" "postgres" {
  name  = "${var.project_name}-${var.environment}-db"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_DB=${var.postgres_db}",
    "POSTGRES_USER=postgres",
    "POSTGRES_PASSWORD=${var.postgres_password}",
  ]

  volumes {
    volume_name    = var.postgres_volume_name
    container_path = "/var/lib/postgresql/data"
  }

  networks_advanced {
    name = var.network_name
  }

  restart = "unless-stopped"
}

# ── Contenedor Frontend ───────────────────────────────────
resource "docker_container" "frontend" {
  name  = "${var.project_name}-${var.environment}-frontend"
  image = docker_image.frontend.image_id

  ports {
    internal = 80
    external = var.frontend_port
  }

  networks_advanced {
    name = var.network_name
  }

  restart = "unless-stopped"

  depends_on = [docker_container.postgres]
}
