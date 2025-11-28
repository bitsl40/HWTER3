resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/ansible.tpl", {
    web_vms = [
      for idx, vm in yandex_compute_instance.web : {
        name     = vm.name
        public_ip = vm.network_interface[0].nat_ip_address
        fqdn     = vm.fqdn  
      }
    ],
    db_vms = [
      for vm_key, vm in yandex_compute_instance.db_vm : {
        name     = vm.name
        public_ip = vm.network_interface[0].nat_ip_address
        fqdn     = vm.fqdn 
      }
    ],
    storage_vms = [
  {
    name     = yandex_compute_instance.storage.name
    public_ip = yandex_compute_instance.storage.network_interface[0].nat_ip_address
    fqdn     = "${yandex_compute_instance.storage.name}.${var.default_zone}.internal"
  }
]

  })
  filename = "${path.module}/inventory.ini"
}
