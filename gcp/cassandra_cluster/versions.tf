# ================= #
# Required Versions #
# ================= #

terraform {
  required_version = ">= 1.4.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.38.0, < 5.0"
    }
  }
}
