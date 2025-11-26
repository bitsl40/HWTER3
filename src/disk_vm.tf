resource "yandex_compute_disk" "my_disk" {
  count = 3
  name   = "disk-${count.index + 1}"
  type   = "network-ssd"
  zone   = "ru-central1-a"
  size   = 1  # размер в ГБ

  labels = {
    environment = "test-disk-${count.index + 1}"
  }
}

resource "yandex_compute_instance" "storage" {
  name = "storage"
  zone = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  
  
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.my_disk 
    content {
      disk_id    = secondary_disk.value.id
      auto_delete = false  
    }
  }

  metadata = {
    serial-port-enable = var.vm_metadata.serial-port-enable
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  } 
}



