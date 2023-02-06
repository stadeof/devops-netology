# Домашнее задание к занятию "2. Облачные провайдеры и синтаксис Terraform."


1. Если не брать уже готовый образ, то его можно создать с помощью "Packer", как мы уже делали на примере Centos.

2. Я просмотрел доступные images с помощью команды:

```
yc compute image list --folder-id standard-images | grep ubuntu
```
Также я вынес отдельно variables.tf и versions.tf 

```terraform
variable "folder_id" {
    type    = string 
    default = "b1gavj4e750dodf8ajlg"
}

variable "zone" {
    type    = string
    default = "ru-central1-a"
}
```
```terraform
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}
```
**main.tf:** 
```terraform
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
            image_id = "fd864gbboths76r8gm5f" ## использую найденный образ ubuntu
            size     = 15 
            type     = "network-ssd"
        }
    }

    network_interface {
        subnet_id = "e9bolutae8c6eeon7ipa"
        nat       = true 
    }
}
```

terraform plan отработал успешно, terraform apply создал заданную ноду

Выполняю terraform destroy:

```
stade@stade-desktop:~/workdir/devops-netology/terraform$ terraform destroy
yandex_compute_instance.vm: Refreshing state... [id=fhmdi9136bgm095ia4to]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:
```
**Ссылка на терраформ:**

https://github.com/stadeof/devops-netology/tree/main/terraform