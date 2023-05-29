### TODO

- Cassandra config on input (as variable)
- Node Exporter setup
- Cassandra Exporter setup
- Extra Disk with mount on Cassandra data directory
- Disks backup (?)
- SSH Key as a secret in Secret Manager

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.38.0, < 5.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.38.0, < 5.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | ~> 4.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_firewall.external_access](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_firewall) | resource |
| [google-beta_google_compute_firewall.self_access](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_firewall) | resource |
| [google_compute_address.non_seeds](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_address.seeds](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_instance.non_seeds](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_instance.seeds](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [null_resource.cluster_provisioning](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_integer.non_seed_zone_ids](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [random_integer.seed_zone_ids](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [time_sleep.userdata](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [tls_private_key.ssh](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [google_compute_image.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image) | data source |
| [google_compute_zones.available](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_distro_family"></a> [distro\_family](#input\_distro\_family) | (Optional) Distributive family (distro\_name-distro\_version). Don't overwrite this without special needs, Cassandra cluster setup is locked by special OS version. | `string` | `"ubuntu-2204-lts"` | no |
| <a name="input_distro_type"></a> [distro\_type](#input\_distro\_type) | (Optional) Distributive type. Example: debian-cloud, cloud-hpc-image-public, fedora-cloud.Don't overwrite this without special needs, Cassandra cluster setup is locked by special OS version. | `string` | `"ubuntu-os-cloud"` | no |
| <a name="input_enable_external_access"></a> [enable\_external\_access](#input\_enable\_external\_access) | (Optional) Whether to enable Firewall rules for external Cassandra access. | `bool` | `true` | no |
| <a name="input_enable_firewall_rules"></a> [enable\_firewall\_rules](#input\_enable\_firewall\_rules) | (Optional) Whether to enable Firewall rules. | `bool` | `true` | no |
| <a name="input_external_cidrs"></a> [external\_cidrs](#input\_external\_cidrs) | (Optional-mandatory) The list of CIDR blocks wo which Cassandra access should be enabled. Should be specified if enable\_external\_access is enabled. | `list(string)` | `[]` | no |
| <a name="input_generate_ssh_key"></a> [generate\_ssh\_key](#input\_generate\_ssh\_key) | (Optional) Whether to generate SSH key or use own. If false, ssh\_key\_name should be specified. | `bool` | `true` | no |
| <a name="input_instance_tags"></a> [instance\_tags](#input\_instance\_tags) | (Optional) The list of instance tags. Also used for firewall rules binding. If not set, the default value from locals will be used. | `list(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The base name of module resources. | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | (Optional) Network to deploy to. | `string` | `"default"` | no |
| <a name="input_non_seed_nodes"></a> [non\_seed\_nodes](#input\_non\_seed\_nodes) | The map of configuration options for Cassandra non seed nodes. | <pre>map(object({<br>    # (Optional) Instance (machine) type.<br>    instance_type = optional(string, "e2-medium")<br><br>    # (Optional) Compute Instance boot disk size.<br>    disk_size = optional(number, 30)<br><br>    # (Optional) Compute Instance boot disk type. Such as pd-standard, pd-balanced or pd-ssd.<br>    disk_type = optional(string, "pd-ssd")<br><br>    # (Optional) The AZ ID. If not specified random AZ will be used.<br>    zone_id = optional(string)<br><br>    # (Optional) Whether to enable public IP address fro the instance.<br>    enable_public_ip = optional(bool, true)<br>  }))</pre> | `{}` | no |
| <a name="input_private_ssh_key"></a> [private\_ssh\_key](#input\_private\_ssh\_key) | (Optional) Private part of external SSH key. Should be specified if generate\_ssh\_key is set to true. | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | (Required) GCP project ID. | `string` | n/a | yes |
| <a name="input_public_ssh_key"></a> [public\_ssh\_key](#input\_public\_ssh\_key) | (Optional) Public part of external SSH key. Should be specified if generate\_ssh\_key is set to true. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | (Required) The Region name. | `string` | n/a | yes |
| <a name="input_seed_nodes"></a> [seed\_nodes](#input\_seed\_nodes) | The map of configuration options for Cassandra seed nodes. | <pre>map(object({<br>    # (Optional) Instance (machine) type.<br>    instance_type = optional(string, "e2-medium")<br><br>    # (Optional) Compute Instance boot disk size.<br>    disk_size = optional(number, 30)<br><br>    # (Optional) Compute Instance boot disk type. Such as pd-standard, pd-balanced or pd-ssd.<br>    disk_type = optional(string, "pd-ssd")<br><br>    # (Optional) The AZ ID. If not specified random AZ will be used.<br>    zone_id = optional(string)<br><br>    # (Optional) Whether to enable public IP address fro the instance.<br>    enable_public_ip = optional(bool, true)<br>  }))</pre> | <pre>{<br>  "s1": {}<br>}</pre> | no |
| <a name="input_ssh_user_name"></a> [ssh\_user\_name](#input\_ssh\_user\_name) | (Optional) The user name to use during SSH connection. | `string` | `"root"` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | (Optional) Subnet to deploy to. | `string` | `"default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_nodes_ips"></a> [cluster\_nodes\_ips](#output\_cluster\_nodes\_ips) | All cluster nodes ips. |
| <a name="output_instance_tags"></a> [instance\_tags](#output\_instance\_tags) | The list of compute instance tags. |
| <a name="output_nodes_count"></a> [nodes\_count](#output\_nodes\_count) | The number of nodes in cluster. |
| <a name="output_ssh_key"></a> [ssh\_key](#output\_ssh\_key) | SSH key. |
<!-- END_TF_DOCS -->