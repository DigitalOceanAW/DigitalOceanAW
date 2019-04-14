resource "digitalocean_firewall" "echo" {
  name = "echoFirewall"
  droplet_ids = ["${digitalocean_droplet.echo.id}"]

  inbound_rule = [
    # SSH
    {
      protocol = "tcp"
      port_range = "22"
      source_addresses = ["0.0.0.0/0"]
    },
    # Server Port
    {
      protocol = "tcp"
      port_range = "80"
      source_addresses = ["0.0.0.0/0"]
    },
    # https needed for git
    {
      protocol = "tcp"
      port_range = "443"
      source_addresses = ["0.0.0.0/0"]
    }
  ]

  outbound_rule = [
    {
      protocol = "tcp"
      port_range = "22"
      destination_addresses = ["0.0.0.0/0"]
    },
    {
      protocol = "tcp"
      port_range = "80"
      destination_addresses = ["0.0.0.0/0"]
    },
    {
      protocol = "tcp"
      port_range = "443"
      destination_addresses = ["0.0.0.0/0"]
    },
    # Needed to lookup github IP
    {
      protocol = "udp"
      port_range = "53"
      destination_addresses = ["0.0.0.0/0"]
    }
  ]
}
