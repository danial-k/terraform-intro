# Backend
terraform {
  backend "local" {}
}

# Provider
provider "docker" {
  version = "2.7.1"
}

# Create an internal private network for container communication
resource "docker_network" "my_network" {
  name = "my-network"
}

# Fetch whoami image
resource "docker_image" "whoami" {
  name = "jwilder/whoami:latest"
}

# Image (nginx)
resource "docker_image" "nginx" {
  name = "terraform-demo/nginx:1.0.1"
}

# Container (nginx)
resource "docker_container" "nginx" {
  name  = "nginx-terraform"
  image = docker_image.nginx.name
  ports {
    internal = 80
    external = 9123
  }
  networks_advanced {
    name = docker_network.my_network.name
  }
}

# Container (whoami)
resource "docker_container" "whoami" {
  for_each = toset(["1", "2", "3"])

  name  = "whoami-terraform-${each.value}"
  image = docker_image.whoami.latest
  ports {
    internal = 8000
  }
  networks_advanced {
    name = docker_network.my_network.name
  }
  # Prevent container from being destroyed
  working_dir = "/app"
}
