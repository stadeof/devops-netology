provider "yandex" {
    cloud_id = "b1gagaienr53r9872vr0"
    folder_id = var.folder_id
    zone = var.zone
}

resource "yandex_compute_instance" "vm" {

    name        = "node"
    hostname    = "node"
    description = "node"
    folder_id   = var.folder_id
    zone        = var.zone
    platform_id = "standard-v2"

    allow_stopping_for_update = true

    resources {
        cores         = 2
        core_fraction = 100
        memory        = 2
    }

    boot_disk {
        initialize_params {
            image_id = "fd864gbboths76r8gm5f"
            size     = 15 
            type     = "network-ssd"
        }
    }

    network_interface {
        subnet_id = "e9bolutae8c6eeon7ipa"
        nat       = true 
    }
}

