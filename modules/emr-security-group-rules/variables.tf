variable "master_security_group_id" {
  description = "Security group ID to apply master rules"
}

variable "slave_security_group_id" {
  description = "Security group ID to apply slave rules"
}

variable "allowed_inbound_cidr_blocks" {
  description = "CIDR blocks to have management UI access to cluster"
  default     = []
  type        = "list"
}

variable "allowed_inbound_security_group_ids" {
  description = "Security group IDs to have management UI access to cluster"
  default     = []
  type        = "list"
}

variable "allowed_ssh_cidr_blocks" {
  description = "CIDR blocks to have SSH access to the cluster"
  default     = []
  type        = "list"
}

variable "allowed_ssh_security_group_ids" {
  description = "Security group IDs to have SSH access to the cluster"
  default     = []
  type        = "list"
}
