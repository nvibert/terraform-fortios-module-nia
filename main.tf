terraform {
  required_providers {
    # Provider source is used for Terraform discovery and installation of
    # providers. Declare source for all providers required by the module.
    fortios = {
      source  = "fortinetdev/fortios"
    }
  }
}

#
# Declare resource blocks to describe module behaviors for the infrastructure.
#
# The example block below describes creating an address group for each Consul
# service and applies an existing policy to the group.
#
resource "fortios_firewall_address" "consul_service" {
  for_each = var.services
  name = each.value.id
  subnet     = "${each.value.address} ${lookup(each.value.meta, "subnet_mask", "255.255.255.255")}"
  type       = "ipmask"
  visibility = "enable"
}


resource "fortios_firewall_addrgrp" "ctsAddrGroup" {
  allow_routing = "disable"
  color         = 0
  exclude       = "disable"
  name          = "groupCts"
  visibility    = "enable"
  dynamic "member" {
    for_each = fortios_firewall_address.consul_service
    content {
      name = member.value["name"]
    }
  }
}


