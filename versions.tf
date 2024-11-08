terraform {
  required_version = ">= 0.14"

  required_providers {
    time = "~> 0.9"
    lacework = {
      source  = "lacework/lacework"
      version = "~> 2.0"
    }
    oci = {
      source  = "oracle/oci"
      version = ">= 5.2.0"
    }
  }
}
