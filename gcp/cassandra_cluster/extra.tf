# =============== #
# Extra Resources #
# =============== #

# Randomize Zone ID for seed nodes
resource "random_integer" "seed_zone_ids" {
  for_each = { for k, v in var.seed_nodes : k => v if(v.zone_id == null) }

  min = 0
  max = length(data.google_compute_zones.available.names) - 1
}

# Randomize Zone ID for non-seed nodes
resource "random_integer" "non_seed_zone_ids" {
  for_each = { for k, v in var.non_seed_nodes : k => v if(v.zone_id == null) }

  min = 0
  max = length(data.google_compute_zones.available.names) - 1
}

# Wait for userdata script to install
resource "time_sleep" "userdata" {
  for_each = merge(google_compute_instance.seeds, google_compute_address.non_seeds)

  depends_on      = [google_compute_instance.seeds, google_compute_address.non_seeds]
  create_duration = "120s"
}
