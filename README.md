## Consul Terraform Sync Module for Fortinet

The module creates an address object per service and an address group if it does not already exist with all address objets. Using the module in automation with [Consul Terraform Sync](https://www.consul.io/docs/nia) will dynamically add or remove service instances from the address group based on [Consul service discovery](https://www.consul.io/).

## Feature

The module creates an address object per service and an address group if it does not already exist with all address objets. The module executes on the default services condition, when there are any changes to the instances of the specified services.

## Requirements

### Ecosystem Requirements

Tested with Consul Terraform Sync 0.3 and Terraform 1.0.7.

Tested with Fortinet v7.0.1 (build 0157).

| Ecosystem | Version |
|-----------|---------|
| [consul](https://www.consul.io/downloads) | >= 1.7 |
| [consul-terraform-sync](https://www.consul.io/docs/nia) | >= 0.1.0 |
| [terraform](https://www.terraform.io) | >= 0.13 |

### Terraform Providers

| Name | Version |
|------|---------|
| fortinetdev/fortios | >= v1.13.1 |

## Setup

Create an [API token](https://registry.terraform.io/providers/fortinetdev/fortios/latest/docs/guides/fgt_token) on the Fortinet appliance for the purpose of automation with Consul Terraform Sync. This token will be used for authentication in Consul Terraform Sync configuration.


## Usage

**User Config for Consul Terraform Sync**

cts-config.hcl
```hcl
consul {
  address = "localhost:8500"
}

driver "terraform" {
  # version = "0.14.0"
  # path = ""
  log = false
  persist_log = false
  working_dir = ""

  
  backend "consul" {
    gzip = true
  }

  required_providers {
    fortios = {
     source = "fortinetdev/fortios"
    }
  }
}

terraform_provider "fortios" {
    hostname = ""
    insecure = ""
    token = ""
}


task {
 name        = "fortinet"
 description = "fortinet"
 providers   = ["fortios"]
 source      = "nvibert/module-nia/fortios"
 # version     = "1.2.0"
 services    = ["fortinet-service"]
 #variable_files = ["../"]
}

```

**User Config for Consul Terraform Sync Enterprise**

Note that you would need a token from Terraform Cloud (or Terraform Enterprise) to authenticate against TFC/TFE.

cts-config.hcl
```hcl
consul {
  address = "localhost:8500"
}

driver "terraform-cloud" {
  hostname = "https://app.terraform.io"
  organization = "nicovibert-org"
  token = "XXXXXXXXXXX"

  required_providers {
    fortios = {
      source = "fortinetdev/fortios"
    }
  }
}

terraform_provider "fortios" {
    hostname = ""
    insecure = ""
    token = ""
}


task {
 name        = "fortinet"
 description = "fortinet"
 providers   = ["fortios"]
 source      = "nvibert/module-nia/fortios"
 # version     = "1.2.0"
 services    = ["fortinet-service"]
 #variable_files = ["../"]
}

```
