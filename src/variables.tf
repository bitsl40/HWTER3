###cloud vars
variable "token" {
  type        = string
  default     = "y0__xCY3bKXAhjB3RMgzOHVjRUw3MaPpggzYINokK5_KPF8w7wYHh-MA9etbg" 
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  default     = "b1gbq8rt47hsq5i7vnf0"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default      = "b1g1cc80vekm2u1stsgv"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Семейство образа ОС"
}

variable "vm_web_nat" {
  type    = bool
  default = true
  description = "Состояние вкл/выкл NAT"
}

variable "vm_metadata" {
  type = object({
    serial-port-enable = number
    #ssh-keys           = string
  })
  description = "Общие metadata для всех ВМ: включение serial‑порта и SSH‑ключи"
  default = {
    serial-port-enable = 1
    #ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINe5CQPAWspyy56JMMB5js6mo0aI2X6owapwEEd19Tjf <опциональный_комментарий>"
  }
}

variable "vms_resources" {
  type = map(object({
    cores          = number
    memory         = number
    core_fraction  = number
    
  }))
  description = "Ресурсы для ВМ: ядра, память, доля ядра"
  default = {
    web = {
      cores          = 2
      memory         = 2
      core_fraction  = 20
    
    }
    db = {
      cores          = 2
      memory         = 2
      core_fraction  = 20
      
    }
  }

}

variable "each_vm" {
  type = list(object({
    vm_name      = string
    cpu          = number
    ram          = number
    disk_volume  = number
  }))
  description = "Список конфигураций ВМ: имя, CPU, RAM (в ГБ), объём диска (в ГБ)"
  default = [
    {
      vm_name     = "main"
      cpu         = 4
      ram         = 8
      disk_volume = 40
    },
    {
      vm_name     = "replica"
      cpu         = 2
      ram         = 4
      disk_volume = 20
    }
  ]
}