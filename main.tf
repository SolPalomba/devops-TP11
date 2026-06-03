# ============================================
# main.tf — Orquesta los módulos
# TP11 — Plan DevOps Operaciones1
# ============================================

module "network" {
  source       = "./modules/network"
  project_name = var.project_name
  environment  = var.environment
}

module "storage" {
  source       = "./modules/storage"
  project_name = var.project_name
  environment  = var.environment
}

module "app" {
  source       = "./modules/app"
  project_name = var.project_name
  environment  = var.environment

  postgres_image    = var.postgres_image
  postgres_password = var.postgres_password
  postgres_db       = var.postgres_db
  frontend_image    = var.frontend_image
  frontend_port     = var.frontend_port

  network_name         = module.network.network_name
  postgres_volume_name = module.storage.postgres_volume_name
}
