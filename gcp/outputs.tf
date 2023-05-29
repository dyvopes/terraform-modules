# ======= #
# Outputs #
# ======= #

output "instance_tags" {
  description = "The list of compute instance tags."
  value       = local.instance_tags
}

output "ssh_key" {
  description = "SSH key."
  value = {
    private = local.private_ssh_key
    public  = local.public_ssh_key
  }
  sensitive = true
}

output "cluster_nodes_ips" {
  description = "All cluster nodes ips."
  value = local.cluster_nodes_ips
}

output "nodes_count" {
  description = "The number of nodes in cluster."
  value = length(local.cluster_nodes_ips)
}
