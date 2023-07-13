terraform {
  required_version = ">= 0.14"

  required_providers {
    lacework = {
      source  = "lacework/lacework"
      version = ">= 1.9.0"
    }
    oci = {
      source  = "oracle/oci"
      version = ">= 5.2.0"
    }
  }
}
