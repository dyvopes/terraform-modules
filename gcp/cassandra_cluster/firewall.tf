# ============== #
# Firewall Rules #
# ============== #

# Self access (for node negotiations)
resource "google_compute_firewall" "self_access" {
  count = var.enable_firewall_rules && length(local.instance_tags) > 0 ? 1 : 0

  name = "${var.name}-self"

  provider = google-beta
  project  = var.project_id

  direction   = "INGRESS"
  network     = var.network
  source_tags = local.instance_tags
  target_tags = local.instance_tags

  allow {
    protocol = "tcp"
    ports    = ["7000-7001"]
  }

  allow {
    protocol = "tcp"
    ports    = ["7199"]
  }

  allow {
    protocol = "icmp"
  }
}

# External node access
resource "google_compute_firewall" "external_access" {
  count = var.enable_firewall_rules && var.enable_external_access && length(local.instance_tags) > 0 && length(var.external_cidrs) > 0 ? 1 : 0

  name = "${var.name}-ext-access"

  provider = google-beta
  project  = var.project_id

  direction     = "INGRESS"
  network       = var.network
  target_tags   = local.instance_tags
  source_ranges = var.external_cidrs

  allow {
    protocol = "tcp"
    ports    = ["9042"]
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
