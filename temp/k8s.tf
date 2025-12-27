# Please review the plan carefully before applying.
resource "google_container_cluster" "autopilot_cluster_1" {
  allow_net_admin                          = null
  datapath_provider                        = "ADVANCED_DATAPATH"
  deletion_protection                      = true
  description                              = null
  disable_l4_lb_firewall_reconciliation    = false
  enable_autopilot                         = true
  enable_cilium_clusterwide_network_policy = false
  enable_fqdn_network_policy               = false
  enable_kubernetes_alpha                  = false
  enable_l4_ilb_subsetting                 = false
  enable_legacy_abac                       = false
  enable_multi_networking                  = false
  enable_tpu                               = false
  in_transit_encryption_config             = "IN_TRANSIT_ENCRYPTION_DISABLED"
  initial_node_count                       = 0
  location                                 = "us-central1"
  min_master_version                       = null
  name                                     = "autopilot-cluster-1"
  network                                  = "projects/pioneering-axe-473420-p5/global/networks/default"
  networking_mode                          = "VPC_NATIVE"
  node_locations                           = ["us-central1-a", "us-central1-b", "us-central1-c", "us-central1-f"]
  node_version                             = "1.33.5-gke.1308000"
  private_ipv6_google_access               = null
  project                                  = "pioneering-axe-473420-p5"
  resource_labels                          = {}
  subnetwork                               = "projects/pioneering-axe-473420-p5/regions/us-central1/subnetworks/default"
  addons_config {
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
    gcp_filestore_csi_driver_config {
      enabled = true
    }
    gcs_fuse_csi_driver_config {
      enabled = true
    }
    gke_backup_agent_config {
      enabled = false
    }
    http_load_balancing {
      disabled = false
    }
    parallelstore_csi_driver_config {
      enabled = true
    }
    ray_operator_config {
      enabled = false
    }
  }
  anonymous_authentication_config {
    mode = "ENABLED"
  }
  authenticator_groups_config {
    security_group = ""
  }
  binary_authorization {
    evaluation_mode = "DISABLED"
  }
  control_plane_endpoints_config {
    dns_endpoint_config {
      allow_external_traffic    = true
      enable_k8s_certs_via_dns  = true
      enable_k8s_tokens_via_dns = true
      endpoint                  = "gke-3dcb5e26c0464acd80a6ce7a558e93f88101-1056969567139.us-central1.gke.goog"
    }
    ip_endpoints_config {
      enabled = true
    }
  }
  database_encryption {
    key_name = null
    state    = "DECRYPTED"
  }
  default_snat_status {
    disabled = false
  }
  dns_config {
    additive_vpc_scope_dns_domain = null
    cluster_dns                   = "CLOUD_DNS"
    cluster_dns_domain            = "cluster.local"
    cluster_dns_scope             = "CLUSTER_SCOPE"
  }
  fleet {
    membership_type = null
    project         = "pioneering-axe-473420-p5"
  }
  gateway_api_config {
    channel = "CHANNEL_STANDARD"
  }
  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-autopilot-cluster-1-pods-3dcb5e26"
    services_secondary_range_name = null
    stack_type                    = "IPV4"
    network_tier_config {
      network_tier = "NETWORK_TIER_DEFAULT"
    }
    pod_cidr_overprovision_config {
      disabled = false
    }
  }
  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }
  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
  master_authorized_networks_config {
    gcp_public_cidrs_access_enabled      = false
    private_endpoint_enforcement_enabled = false
  }
  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS", "STORAGE", "POD", "DEPLOYMENT", "STATEFULSET", "DAEMONSET", "HPA", "JOBSET", "CADVISOR", "KUBELET", "DCGM"]
    advanced_datapath_observability_config {
      enable_metrics = true
      enable_relay   = false
    }
    managed_prometheus {
      enabled = true
      auto_monitoring_config {
        scope = "NONE"
      }
    }
  }
  node_pool_auto_config {
    resource_manager_tags = {}
    node_kubelet_config {
      insecure_kubelet_readonly_port_enabled = "FALSE"
    }
  }
  node_pool_defaults {
    node_config_defaults {
      insecure_kubelet_readonly_port_enabled = "FALSE"
      logging_variant                        = "DEFAULT"
      gcfs_config {
        enabled = true
      }
    }
  }
  notification_config {
    pubsub {
      enabled = false
      topic   = null
    }
  }
  pod_autoscaling {
    hpa_profile = "PERFORMANCE"
  }
  private_cluster_config {
    enable_private_endpoint     = false
    enable_private_nodes        = false
    master_ipv4_cidr_block      = null
    private_endpoint_subnetwork = null
    master_global_access_config {
      enabled = false
    }
  }
  rbac_binding_config {
    enable_insecure_binding_system_authenticated   = false
    enable_insecure_binding_system_unauthenticated = false
  }
  release_channel {
    channel = "REGULAR"
  }
  secret_manager_config {
    enabled = false
    rotation_config {
      enabled           = false
      rotation_interval = null
    }
  }
  security_posture_config {
    mode               = "BASIC"
    vulnerability_mode = "VULNERABILITY_DISABLED"
  }
  service_external_ips_config {
    enabled = false
  }
  vertical_pod_autoscaling {
    enabled = true
  }
  workload_identity_config {
    workload_pool = "pioneering-axe-473420-p5.svc.id.goog"
  }
}

import {
  id = "projects/pioneering-axe-473420-p5/locations/us-central1/clusters/autopilot-cluster-1"
  to = google_container_cluster.autopilot_cluster_1
}
