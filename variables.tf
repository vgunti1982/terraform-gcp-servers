variable "gcp_project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "gcp_region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "num_instances" {
  description = "Number of instances"
  type        = number
  default     = 1
}

variable "machine_type" {
  description = "Machine type"
  type        = string
  default     = "e2-standard-4"
}

variable "image" {
  description = "Boot disk image"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "boot_disk_size" {
  description = "Boot disk size in GB"
  type        = number
  default     = 50
}

variable "subnet_cidr" {
  description = "Subnet CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "allowed_ssh_ips" {
  description = "Allowed SSH IPs"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_splunk_ips" {
  description = "Allowed Splunk IPs"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
