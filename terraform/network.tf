resource "google_compute_network" "vpc_network" {
  name                    = "kubernetes-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "nodes_subnet" {
  name          = "kubernetes-subnet"
  ip_cidr_range = var.CIDR[0]
  region        = "europe-north1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "ssh" {
  name = "kubernetes-ssh-rule"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "kubernetes" {
  name = "kubernetes-sys-rule"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports = ["6443", "2379-2380", "10250", "10259","10257", "30000-32767", "6783", "443"]
  }

  allow{
    protocol = "udp"
    ports = ["6783-6784"]
  }
  source_ranges = var.CIDR
}