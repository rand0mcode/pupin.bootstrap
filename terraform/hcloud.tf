
data "hcloud_ssh_keys" "all_keys" {
}

data "hetznerdns_zone" "dns_zone" {
  name = var.dns_zone
}

resource "hcloud_network" "network" {
  name     = "network"
  ip_range = "10.0.0.0/8"
}

resource "hcloud_network_subnet" "subnet" {
  network_id   = hcloud_network.network.id
  type         = "server"
  network_zone = "eu-central"
  ip_range     = "10.0.8.0/24"

  depends_on = [hcloud_network.network]
}

resource "hcloud_server" "nodes" {
  for_each    = var.machines
  name        = "${each.key}.priv.${var.dns_zone}"
  image       = each.value.image
  server_type = each.value.server_type
  ssh_keys    = data.hcloud_ssh_keys.all_keys.ssh_keys.*.name
  location    = "fsn1"

  network {
    network_id = hcloud_network.network.id
    ip         = each.value.ip
  }

  depends_on = [hcloud_network_subnet.subnet]
}

resource "hetznerdns_record" "private_addresses" {
    for_each = var.machines
    zone_id = data.hetznerdns_zone.dns_zone.id
    name = "${each.key}.priv"
    value = each.value.ip
    type = "A"
    ttl= 60
}

resource "hetznerdns_record" "public_addresses" {
    for_each = var.machines
    zone_id = data.hetznerdns_zone.dns_zone.id
    name = "${each.key}.pub"
    value = hcloud_server.nodes[each.key].ipv4_address
    type = "A"
    ttl= 60
}
