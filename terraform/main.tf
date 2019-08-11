resource "google_compute_instance" "raddit" {
  name         = "raddit-instance"
  machine_type = "n1-standard-1"
  zone         = "australia-southeast1-c"

  # boot disk specifications
  boot_disk {
    initialize_params {
      image = "raddit-base-1564305716" // use image built with Packer
    }
  }

  # networks to attach to the VM
  network_interface {
    network = "default"
    access_config {} // use ephemeral public IP
  }
}

resource "google_compute_project_metadata" "raddit" {
  metadata = {
    ssh-keys = "ryan:${file("~/.ssh/id_rsa.pub")}" // path to ssh key file
  }
}

resource "google_compute_firewall" "raddit" {
  name    = "allow-raddit-tcp-9292"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
}