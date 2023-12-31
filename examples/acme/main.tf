module "bootstrap" {
  source = "git::https://github.com/mojaloop/iac-aws-bootstrap.git?ref=v2beta"
  tags = {
    "Origin" = "Managed by Terraform"
    "mojaloop/cost_center" = "oss-iac-test"
    "mojaloop/owner" = "jdoe"
    "Tenant" = var.tenant
  }

  domain       = "mojatest.live"
  tenant       = var.tenant             # The Tenant name (probably the name of the customer - this should be the same as ths "tenant" above)
  region       = var.region        # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions
  environments = var.environments            # Comma Separated list of environments in this tenant.    e.g. ["dev","qa","test1"]
  gitlab_use_staging_letsencrypt = false
  iac_group_name = "iac_admin"
  enable_github_oauth     = false
  gitlab_rbac_groups      = var.gitlab_rbac_groups
  smtp_server_enable      = true
  gitlab_version          = "14.8.2"
  cidr_block_index = var.cidr_block_index
  max_number_availability_zones = 1
}


variable "environments" {
  description = "environments to install"
  type        = list(string)
  default     = ["dev"]
}
variable "cidr_block_index" {
  description = "index for cidr block assignments"
  type        = map(number)
  default     = {
      "dev" = 0
  }
}
variable "gitlab_rbac_groups" {
  description = "list of groups to configure"
  type        = list(string)
  default     = ["tenant-admins", "tenant-viewers"]
}
variable "region" {
  description = "region to install in"
  type        = string
  default     = "eu-west-1"
}
variable "tenant" {
  description = "tenant name"
  type        = string
  default     = "tenancy1"
}
############################################### DO NOT EDIT BELOW THIS LINE #############################################

terraform {
  backend "s3" {
    key = "bootstrap/terraform.tfstate"
  }
}

output "gitlab_ssh_private_key" {
  value       = module.bootstrap.gitlab_ssh_private_key
  description = "SSH key to access GitLab VM"
}

output "gitlab_root_pw" {
  value       = module.bootstrap.gitlab_root_pw
  description = "root pw for gitlab"
  sensitive   = true
}

output "domain" {
  value       = module.bootstrap.domain
  description = "Base domain used for this tenant"
}

output "vpc_id" {
  value       = module.bootstrap.vpc_id
  description = "VPC ID used as base for this tenant"
}

output "public_subnet_ids" {
  value = module.bootstrap.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.bootstrap.private_subnet_ids
}

output "private_zone_name" {
  value = module.bootstrap.private_zone_name
}

output "public_zone_id" {
  value = module.bootstrap.public_zone_id
}

output "public_zone_name" {
  value = module.bootstrap.public_zone_name
}

output "gitlab_server_ip" {
  value = module.bootstrap.gitlab_server_ip
}

output "gitlab_hostname" {
  value = module.bootstrap.gitlab_hostname
}

output "gitlab_ci_public_ip" {
  value = module.bootstrap.gitlab_ci_public_ip
}

output "gitlab_ci_private_ip" {
  value = module.bootstrap.gitlab_ci_private_ip
}

output "wireguard_public_ip" {
  value = module.bootstrap.wireguard_public_ip
}

output "wireguard_private_ip" {
  value = module.bootstrap.wireguard_private_ip
}

output "wireguard_private_key" {
  value = module.bootstrap.wireguard_ssh_private_key
  sensitive   = true
}

output "wireguard_ui_admin_pw" {
  value = module.bootstrap.wireguard_ui_admin_pw
  sensitive   = true
}

output "wireguard_vpn_hostname" {
  value       = module.bootstrap.wireguard_vpn_hostname
  description = "Public Wireguard hostname"
}

output "nexus_admin_pw" {
  description = "nexus admin password"
  value       = module.bootstrap.nexus_admin_pw
  sensitive   = true
}

output "nexus_fqdn" {
  description = "FQDN for for Nexus Server"
  value       = module.bootstrap.nexus_fqdn
}

output "nexus_docker_repo_listening_port" {
  description = "FQDN for for Nexus Server"
  value       = module.bootstrap.nexus_docker_repo_listening_port
}

output "nexus_ssh_public_key" {
  description = "FQDN for for Nexus Server"
  value       = module.bootstrap.nexus_ssh_public_key
}

output "nexus_ssh_private_key" {
  description = "FQDN for for Nexus Server"
  value       = module.bootstrap.nexus_ssh_private_key
  sensitive   = true
}

output "iac_user_key_id" {
  description = "key id for iac user"
  value       = module.bootstrap.iac_user_key_id
  sensitive   = false
}

output "iac_user_key_secret" {
  description = "key secret for iac user"
  value       = module.bootstrap.iac_user_key_secret
  sensitive   = true
}

output "public_subnets_natgw_ip" {
  description = "Full access to the public subnet objects"
  value       = module.bootstrap.public_subnets.ngw_public_ip
}

output "gitlab_root_token" {
  value       = module.bootstrap.gitlab_root_token
  description = "root pw for gitlab"
  sensitive   = true
}

output "environments" {
  value       = var.environments
  description = "envs"
}

output "gitlab_rbac_groups" {
  value       = var.gitlab_rbac_groups
}
output "region" {
  value       = var.region
}
output "tenant" {
  value       = var.tenant
}

output "ses_user" {
  value = module.bootstrap.ses_user
}
output "ses_pw" {
  value = module.bootstrap.ses_pw
  sensitive   = true
}
output "availability_zones" {
  description = "azs used in tenancy"
  value       = module.bootstrap.availability_zones
}