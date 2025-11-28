[webservers]
%{ for vm in web_vms ~}
${vm.name} ansible_host=${vm.public_ip} fqdn=${vm.fqdn}
%{ endfor ~}

[databases]
%{ for vm in db_vms ~}
${vm.name} ansible_host=${vm.public_ip} fqdn=${vm.fqdn}
%{ endfor ~}

[storage]
%{ for vm in storage_vms ~}
${vm.name} ansible_host=${vm.public_ip} fqdn=${vm.fqdn}
%{ endfor ~}
