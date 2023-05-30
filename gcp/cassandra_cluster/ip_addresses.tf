# =================== #
# Public IP Addresses #
# =================== #

resource "google_compute_address" "seeds" {
  for_each = { for k, v in var.seed_nodes : k => v if(v.enable_public_ip) }

  name   = "${var.name}-seed-${each.key}"
  region = var.region
}

resource "google_compute_address" "non_seeds" {
  for_each = { for k, v in var.non_seed_nodes : k => v if(v.enable_public_ip) }

  name   = "${var.name}-seed-${each.key}"
  region = var.region
}
