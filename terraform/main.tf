resource "google_compute_instance" "control_plane_node" {
    count = 1   
    name = "master${count.index + 1}"
    machine_type = "e2-medium"

    boot_disk {
        initialize_params {
            image = "ubuntu-os-cloud/ubuntu-2004-lts"
        }
    }
    network_interface {
        subnetwork = google_compute_subnetwork.nodes_subnet.name
        access_config {
        }
    }
}

resource "google_compute_instance" "worker_node" {
    count = 2
    
    name = "worker${count.index + 1}"
    machine_type = "e2-medium"

    boot_disk {
        initialize_params {
            image = "ubuntu-os-cloud/ubuntu-2004-lts"
        }
    }
    network_interface {
        subnetwork = google_compute_subnetwork.nodes_subnet.name
        access_config {
        }
    }
}