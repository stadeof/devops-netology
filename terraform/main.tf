terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
    cloud_id = "b1gagaienr53r9872vr0"
    folder_id = var.folder_id
    zone = var.zone
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

resource "yandex_compute_instance" "node01" {

    name        = "node01"
    hostname    = "node01"
    description = "my test node"
    folder_id   = var.folder_id
    zone        = var.zone
    platform_id = "standard-v2"

    allow_stopping_for_update = true

    resources {
        cores         = 2
        core_fraction = 100
        memory        = 4
    }

    boot_disk {
        initialize_params {
            image_id = "fd8uc1vvpjqho0i9skl9"
            size     = 30 
            type     = "network-ssd"
        }
    }

    network_interface {
        subnet_id = "e9bolutae8c6eeon7ipa"
        nat       = true 
    }
}

variable "folder_id" {
    type    = string 
    default = "b1gavj4e750dodf8ajlg"
}

variable "zone" {
    type    = string
    default = "ru-central1-a"
}