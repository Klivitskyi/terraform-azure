variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "East US"
}

variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "rg_name" {
  description = "The name of the Azure resource group"
  type        = string
}

variable "dns_name" {
  description = "The DNS prefix for the AKS cluster"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 2
}

variable "username" {
  description = "Admin username for the cluster nodes"
  type        = string
  default     = "adminroot"
}
