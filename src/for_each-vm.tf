resource "yandex_compute_instance" "db_vm" {
  for_each = { for vm in var.each_vm : vm.vm_name => vm }

  name = each.value.vm_name
  zone = "ru-central1-a"

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
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