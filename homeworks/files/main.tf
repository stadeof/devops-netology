terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-a"
  service_account_key_file = file("key.json")
  folder_id = "b1gavj4e750dodf8ajlg"
}

# создаем сетку 
resource "yandex_vpc_network" "netology_vpc" {
  name  = "netology-vpc"
}

# публичная сеть
resource "yandex_vpc_subnet" "public_subnet" {
  name           = "public"
  network_id     = yandex_vpc_network.netology_vpc.id
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["192.168.10.0/24"]
}

# приватная сеть 
resource "yandex_vpc_subnet" "private_subnet" {
  name           = "private"
  network_id     = yandex_vpc_network.netology_vpc.id
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["192.168.20.0/24"]

  route_table_id = yandex_vpc_route_table.netology_route_table.id
}



# Создаем nat vm
resource "yandex_compute_instance" "nat_instance" {
  name         = "nat-instance"
  zone         = "ru-central1-a"
  platform_id  = "standard-v2"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }
  network_interface {
    subnet_id    = yandex_vpc_subnet.public_subnet.id
    nat          = true
    ip_address   = "192.168.10.254"
  }
  metadata = {
    ssh-keys   = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDnzJxj+Ifu0egvQiwst/dABhzxxZWE2YrE8fkpgFTgiGoldr6ssGC6XKhXkz3GlDfIXrhqQ3RixHZNwtW3P+ibVX8BKElmbU4vEdHSbRsP+vbTBdec5osE5DFQ+bZuvMtU4/tk7/UVjb9yYAAMl25GI1W93k96mqYCVDE9/+fOURVxH/fkaZMzvAoXQ4aYrGGy79ON7sly1rlZZM2NY76jdx0BvORDqOWrWzx1UTi1yeByXeCiu1nCoX5lyCKTE94QrQ2/7dmeAyUA1mAcyMiqw1SVRu7lTJ05RckrWmM/Dq5fStlQlfiDNyY9PVSh2tjSWAZm6Cg60ZIvy+5XFRQKRlFwQLXKKUy3zTUGnR38E2tRTYl/7xW7/II6+Q2YAAzYQ2tA4n4xr5T1nh1azTI9sbROkLIy7nSrV/ueR5InP5jrX+yVt/ZA07dgK0yfLUfmHFTooYFz9VQY2AGtUnm7h2xfmKscIRCOa489/yCqFIzhB1CNAiOaaHiXy8pVsfU= stade@stade-B760M-AORUS-ELITE-AX"
 }
}


# Создаем роуттейбл и перенаправляем трафик
resource "yandex_vpc_route_table" "netology_route_table" {
  name  = "netology-route-table"
  network_id = yandex_vpc_network.netology_vpc.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address  = yandex_compute_instance.nat_instance.network_interface.0.ip_address
   }
}

# Создаем публичную машинку
resource "yandex_compute_instance" "public_instance" {
  name         = "public-instance"
  zone         = "ru-central1-a"
  platform_id  = "standard-v2"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }
  network_interface {
    subnet_id    = yandex_vpc_subnet.public_subnet.id
    nat          = true
  }
  metadata = {
    ssh-keys   = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDnzJxj+Ifu0egvQiwst/dABhzxxZWE2YrE8fkpgFTgiGoldr6ssGC6XKhXkz3GlDfIXrhqQ3RixHZNwtW3P+ibVX8BKElmbU4vEdHSbRsP+vbTBdec5osE5DFQ+bZuvMtU4/tk7/UVjb9yYAAMl25GI1W93k96mqYCVDE9/+fOURVxH/fkaZMzvAoXQ4aYrGGy79ON7sly1rlZZM2NY76jdx0BvORDqOWrWzx1UTi1yeByXeCiu1nCoX5lyCKTE94QrQ2/7dmeAyUA1mAcyMiqw1SVRu7lTJ05RckrWmM/Dq5fStlQlfiDNyY9PVSh2tjSWAZm6Cg60ZIvy+5XFRQKRlFwQLXKKUy3zTUGnR38E2tRTYl/7xW7/II6+Q2YAAzYQ2tA4n4xr5T1nh1azTI9sbROkLIy7nSrV/ueR5InP5jrX+yVt/ZA07dgK0yfLUfmHFTooYFz9VQY2AGtUnm7h2xfmKscIRCOa489/yCqFIzhB1CNAiOaaHiXy8pVsfU= stade@stade-B760M-AORUS-ELITE-AX"
 }
}

# Создаем приватную машинку

resource "yandex_compute_instance" "private_instance" {
  name         = "private-instance"
  zone         = "ru-central1-a"
  platform_id  = "standard-v2"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }
  network_interface {
    subnet_id    = yandex_vpc_subnet.private_subnet.id
  }
  metadata = {
    ssh-keys   = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDnzJxj+Ifu0egvQiwst/dABhzxxZWE2YrE8fkpgFTgiGoldr6ssGC6XKhXkz3GlDfIXrhqQ3RixHZNwtW3P+ibVX8BKElmbU4vEdHSbRsP+vbTBdec5osE5DFQ+bZuvMtU4/tk7/UVjb9yYAAMl25GI1W93k96mqYCVDE9/+fOURVxH/fkaZMzvAoXQ4aYrGGy79ON7sly1rlZZM2NY76jdx0BvORDqOWrWzx1UTi1yeByXeCiu1nCoX5lyCKTE94QrQ2/7dmeAyUA1mAcyMiqw1SVRu7lTJ05RckrWmM/Dq5fStlQlfiDNyY9PVSh2tjSWAZm6Cg60ZIvy+5XFRQKRlFwQLXKKUy3zTUGnR38E2tRTYl/7xW7/II6+Q2YAAzYQ2tA4n4xr5T1nh1azTI9sbROkLIy7nSrV/ueR5InP5jrX+yVt/ZA07dgK0yfLUfmHFTooYFz9VQY2AGtUnm7h2xfmKscIRCOa489/yCqFIzhB1CNAiOaaHiXy8pVsfU= stade@stade-B760M-AORUS-ELITE-AX"
 }
}
