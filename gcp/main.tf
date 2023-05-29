# ================= #
# Cassandra Cluster #
# ================= #

# Seed nodes
resource "google_compute_instance" "seeds" {
  for_each = var.seed_nodes

  name = "${var.name}-seed-${each.key}"

  machine_type = each.value.instance_type
  zone         = each.value.zone_id != null ? each.value.zone_id : data.google_compute_zones.available.names[random_integer.seed_zone_ids[each.key].result]
  tags         = local.instance_tags

  boot_disk {
    initialize_params {
      image = data.google_compute_image.this.self_link
      size  = each.value.disk_size
      type  = each.value.disk_type
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    dynamic "access_config" {
      for_each = each.value.enable_public_ip ? [1] : []

      content {
        nat_ip = google_compute_address.seeds[each.key].address
      }
    }
  }

  metadata = {
    ssh-keys = format("%s%s%s", var.ssh_user_name, ":", local.public_ssh_key)
  }

  # Userdata
  metadata_startup_script = file("${path.module}/templates/userdata.sh")
}

# Non seed nodes
resource "google_compute_instance" "non_seeds" {
  for_each = var.non_seed_nodes

  name = "${var.name}-nonseed-${each.key}"

  machine_type = each.value.instance_type
  zone         = each.value.zone_id != null ? each.value.zone_id : data.google_compute_zones.available.names[random_integer.non_seed_zone_ids[each.key].result]
  tags         = local.instance_tags

  boot_disk {
    initialize_params {
      image = data.google_compute_image.this.self_link
      size  = each.value.disk_size
      type  = each.value.disk_type
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    dynamic "access_config" {
      for_each = each.value.enable_public_ip ? [1] : []

      content {
        nat_ip = google_compute_address.non_seeds[each.key].address
      }
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user_name}:${local.public_ssh_key}"
  }

  # Userdata
  metadata_startup_script = file("${path.module}/templates/userdata.sh")
}
