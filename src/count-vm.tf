


resource "yandex_compute_instance" "web" {
  count = 2
  name  = "web-${count.index + 1}"
  zone  = "ru-central1-a"
 
  depends_on = [yandex_compute_instance.db_vm]
  
  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
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

  metadata = {
    serial-port-enable = var.vm_metadata.serial-port-enable
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  } 

  }
  
