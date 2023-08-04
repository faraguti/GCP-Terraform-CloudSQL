terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.76.0"
    }
  }
}

provider "google" {
  project = "felipe-faraguti"
  region  = "us-west1"
  zone    = "us-west1-a"
}
