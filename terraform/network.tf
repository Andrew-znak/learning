resource "google_compute_network" "vpc_network" {
  name                    = "kubernetes-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "nodes_subnet" {
  name          = "kubernetes-subnet"
  ip_cidr_range = "10.0.1.0/24"
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