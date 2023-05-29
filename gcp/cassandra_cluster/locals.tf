# ====== #
# Locals #
# ====== #

locals {
  # Instance tags
  instance_tags = var.instance_tags != null ? var.instance_tags : ["${var.name}-tag"]

  # SSH key
  public_ssh_key  = var.generate_ssh_key ? tls_private_key.ssh[0].public_key_openssh : var.public_ssh_key
  private_ssh_key = var.generate_ssh_key ? tls_private_key.ssh[0].private_key_openssh : var.private_ssh_key

  # Seed nodes internal IP addresses
  seed_nodes_internal_ips = join(",", values(google_compute_instance.seeds)[*].network_interface.0.network_ip)

  # All cluster nodes IP addresses
  cluster_nodes_ips = merge(
    # Seeds
    { for node, data in google_compute_instance.seeds : node => { internal_ip = data.network_interface.0.network_ip, public_ip = try(data.network_interface.0.access_config.0.nat_ip, "") } },
    # Non Seeds
    { for node, data in google_compute_instance.non_seeds : node => { internal_ip = data.network_interface.0.network_ip, public_ip = try(data.network_interface.0.access_config.0.nat_ip, "") } }
  )
}
