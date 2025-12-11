terraform {
  backend "gcs" {
    bucket = "terraform-state-bucket"
    prefix = "gcp-servers-prod"
  }
}
