# ============ #
# Data Sources #
# ============ #

# Get all AZs of GCP Region
data "google_compute_zones" "available" {
  region = var.region
}

# Get distributive name
data "google_compute_image" "this" {
  family  = var.distro_family
  project = var.distro_type
}
