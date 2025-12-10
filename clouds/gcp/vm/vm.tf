resource "google_compute_instance" "instantinfra" {
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  machine_type = "e2-standard-2"

  name = "${var.prefix}-gce"
  zone = "${var.region}-a"

  metadata_startup_script = "echo instantinfra > /test.txt"

  network_interface {
    network = data.google_compute_network.default.name
  }
}