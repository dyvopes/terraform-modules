# ======== #
# SSH Keys #
# ======== #

# For remote provisioner
resource "tls_private_key" "ssh" {
  count = var.generate_ssh_key ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = 4096
}
