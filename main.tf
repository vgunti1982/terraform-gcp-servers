# ============================================================
# main.tf - GCP Server Provisioning
# See docs/ for complete documentation
# ============================================================

terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  
  backend "gcs" {
    bucket = "your-terraform-state-bucket"
    prefix = "gcp-servers"
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

data "google_client_config" "current" {}

# VPC Network
resource "google_compute_network" "vpc" {
  name                    = "${var.environment}-vpc"
  auto_create_subnetworks = false
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.environment}-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.gcp_region
  network       = google_compute_network.vpc.id
}

# Firewall - SSH
resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.environment}-allow-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = var.allowed_ssh_ips
}

# Firewall - Splunk
resource "google_compute_firewall" "allow_splunk" {
  name    = "${var.environment}-allow-splunk"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["8000", "8089", "9997"]
  }
  source_ranges = var.allowed_splunk_ips
}

# Service Account
resource "google_service_account" "splunk_sa" {
  account_id   = "${var.environment}-splunk-sa"
  display_name = "Service Account for Splunk instances"
}

# IAM Role binding
resource "google_project_iam_member" "logging_write" {
  project = var.gcp_project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.splunk_sa.email}"
}

# Compute Instances
resource "google_compute_instance" "splunk_servers" {
  count           = var.num_instances
  name            = "${var.environment}-splunk-server-${count.index + 1}"
  machine_type    = var.machine_type
  zone            = "${var.gcp_region}-a"
  tags            = ["splunk-server", var.environment]

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.boot_disk_size
    }
  }

  network_interface {
    network    = google_compute_network.vpc.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config {
      nat_ip = google_compute_address.static_ip[count.index].address
    }
  }

  service_account {
    email  = google_service_account.splunk_sa.email
    scopes = ["cloud-platform"]
  }

  metadata = {
    enable-oslogin = "TRUE"
  }
}

# Static IPs
resource "google_compute_address" "static_ip" {
  count  = var.num_instances
  name   = "${var.environment}-splunk-ip-${count.index + 1}"
  region = var.gcp_region
}

# Outputs
output "instance_ips" {
  value = [for addr in google_compute_address.static_ip : addr.address]
  description = "Static IPs of instances"
}

output "instance_names" {
  value = [for instance in google_compute_instance.splunk_servers : instance.name]
  description = "Names of instances"
}

output "instance_details" {
  value = [for idx, instance in google_compute_instance.splunk_servers : {
    name       = instance.name
    ip         = google_compute_address.static_ip[idx].address
    internal_ip = instance.network_interface[0].network_ip
  }]
  description = "Detailed instance information"
}
