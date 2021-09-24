terraform {
  required_providers {
    # Provider source is used for Terraform discovery and installation of
    # providers. Declare source for all providers required by the module.
    fortios = {
      source  = "fortinetdev/fortios"
    }
  }
}

provider "fortios" {
  
}
#
# Declare resource blocks to describe module behaviors for the infrastructure.
#
# The example block below describes creating an address group for each Consul
# service and applies an existing policy to the group.
#
resource "fortios_firewall_address" "consul_service" {
  for_each = var.services
  end_ip     = "255.255.255.0"
  name       = each.value.name
  start_ip   = each.value.address
} 


#
# You can utilize the locals block to transform the var.services variable
# into a data structure for your module. For more examples of common data
# transformations visit the project wiki.
#
# The example below converts var.services to a map of service names to a list
# of service instances.


#locals {
  # Group service instances by service name
  # consul_services = {
  #   "app" = [
  #     {
  #       "id" = "app-id-01"
  #       "name" = "app"
  #       "node_address" = "192.168.10.10"
  #     }
  #   ]
  # }
#  consul_services = {
#    for id, s in var.services : s.name => s...
#  }
#}



