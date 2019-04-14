data "digitalocean_image" "echoServer" {
  name = "echoServer"
}

provider "digitalocean" {
}

resource "digitalocean_droplet" "echo" {
  image = "${data.digitalocean_image.echoServer.image}"
  name = "echoServer"
  region = "sfo2"
  size = "512mb"
  ssh_keys = ["${digitalocean_ssh_key.echoKey.fingerprint}"]

  provisioner "remote-exec" {
    inline = [
      # Echo refers to the container, not the bash command.
      "docker exec -it echo apk add git python3 python3-dev",
      "docker exec -it echo python3 -m ensure-pip",
      "docker exec -it echo pip3 install Flask",
      "docker exec -it echo git clone https://github.com/DigitalOceanAW/DigitalOceanAW ~/DigitalOceanAW"
    ]
  }
}

resource "digitalocean_ssh_key" "echoKey" {
  name = "echoServer ssh key"
  public_key = "${file("../.secrets/ansible_ssh.pub")}"
}

output "ip_addr" {
  value = "${digitalocean_droplet.echo.ipv4_address}"
}
