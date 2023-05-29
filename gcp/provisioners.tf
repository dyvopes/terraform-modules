# ====================== #
# Cassandra Provisioners #
# ====================== #

resource "null_resource" "cluster_provisioning" {
  for_each = local.cluster_nodes_ips

  triggers = {
    seed_ips = local.seed_nodes_internal_ips
  }

  # Cassandra configuration file
  provisioner "file" {
    content = templatefile("${path.module}/templates/cassandra_config.yaml.tmpl", {
      cluster_name = var.name
      host_ip      = each.value.internal_ip
      seed_ips     = local.seed_nodes_internal_ips
    })
    destination = "/tmp/cassandra.yaml"

    connection {
      type        = "ssh"
      host        = each.value.public_ip
      user        = var.ssh_user_name
      private_key = local.private_ssh_key
    }
  }

  # Script to reconfigure Cassandra after configuration file change
  provisioner "file" {
    source      = "${path.module}/templates/reconfigure_cassandra.sh"
    destination = "/tmp/reconfigure_cassandra.sh"

    connection {
      type        = "ssh"
      host        = each.value.public_ip
      user        = var.ssh_user_name
      private_key = local.private_ssh_key
    }
  }

  # Scripts executing
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/reconfigure_cassandra.sh",
      "sudo bash /tmp/reconfigure_cassandra.sh",
    ]

    connection {
      type        = "ssh"
      host        = each.value.public_ip
      user        = var.ssh_user_name
      private_key = local.private_ssh_key
    }
  }

  # Wait for userdata to install
  depends_on = [time_sleep.userdata]
}
