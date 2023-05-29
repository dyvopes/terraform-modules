# ================== #
# Required variables #
# ================== #

variable "name" {
  description = "(Required) The base name of module resources."
  type        = string
}

variable "region" {
  description = "(Required) The Region name."
  type        = string
}

variable "project_id" {
  description = "(Required) GCP project ID."
  type        = string
}

variable "seed_nodes" {
  description = "The map of configuration options for Cassandra seed nodes."
  type = map(object({
    # (Optional) Instance (machine) type.
    instance_type = optional(string, "e2-medium")

    # (Optional) Compute Instance boot disk size.
    disk_size = optional(number, 30)

    # (Optional) Compute Instance boot disk type. Such as pd-standard, pd-balanced or pd-ssd.
    disk_type = optional(string, "pd-ssd")

    # (Optional) The AZ ID. If not specified random AZ will be used.
    zone_id = optional(string)

    # (Optional) Whether to enable public IP address fro the instance.
    enable_public_ip = optional(bool, true)
  }))
  default = {
    s1 = {}
  }

  validation {
    condition     = length(var.seed_nodes) >= 1
    error_message = "Validation Error! Not enough seed nodes in cluster. Minimal node count is 1."
  }
}

variable "non_seed_nodes" {
  description = "The map of configuration options for Cassandra non seed nodes."
  type = map(object({
    # (Optional) Instance (machine) type.
    instance_type = optional(string, "e2-medium")

    # (Optional) Compute Instance boot disk size.
    disk_size = optional(number, 30)

    # (Optional) Compute Instance boot disk type. Such as pd-standard, pd-balanced or pd-ssd.
    disk_type = optional(string, "pd-ssd")

    # (Optional) The AZ ID. If not specified random AZ will be used.
    zone_id = optional(string)

    # (Optional) Whether to enable public IP address fro the instance.
    enable_public_ip = optional(bool, true)
  }))
  default = {
    # ns1 = {}
    # ns2 = {}
  }

  # validation {
  #   condition     = length(var.non_seed_nodes) >= 2
  #   error_message = "Validation Error! Not enough non seed nodes in cluster. Minimal node count is 2."
  # }
}

# ================== #
# Optional variables #
# ================== #

variable "instance_tags" {
  description = "(Optional) The list of instance tags. Also used for firewall rules binding. If not set, the default value from locals will be used."
  type        = list(string)
  default     = null
}

variable "distro_type" {
  description = "(Optional) Distributive type. Example: debian-cloud, cloud-hpc-image-public, fedora-cloud.Don't overwrite this without special needs, Cassandra cluster setup is locked by special OS version."
  type        = string
  default     = "ubuntu-os-cloud"
}

variable "distro_family" {
  description = "(Optional) Distributive family (distro_name-distro_version). Don't overwrite this without special needs, Cassandra cluster setup is locked by special OS version."
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "network" {
  description = "(Optional) Network to deploy to."
  type        = string
  default     = "default"
}

variable "subnetwork" {
  description = "(Optional) Subnet to deploy to."
  type        = string
  default     = "default"
}

variable "enable_firewall_rules" {
  description = "(Optional) Whether to enable Firewall rules."
  type        = bool
  default     = true
}

variable "enable_external_access" {
  description = "(Optional) Whether to enable Firewall rules for external Cassandra access."
  type        = bool
  default     = true
}

variable "external_cidrs" {
  description = "(Optional-mandatory) The list of CIDR blocks wo which Cassandra access should be enabled. Should be specified if enable_external_access is enabled."
  type        = list(string)
  default     = []
}

variable "generate_ssh_key" {
  description = "(Optional) Whether to generate SSH key or use own. If false, ssh_key_name should be specified."
  type        = bool
  default     = true
}

variable "ssh_user_name" {
  description = "(Optional) The user name to use during SSH connection."
  type        = string
  default     = "root"
}

variable "public_ssh_key" {
  description = "(Optional) Public part of external SSH key. Should be specified if generate_ssh_key is set to true."
  type        = string
  default     = null
}

variable "private_ssh_key" {
  description = "(Optional) Private part of external SSH key. Should be specified if generate_ssh_key is set to true."
  type        = string
  default     = null
}
