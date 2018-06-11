#------------------------------------------------
# Required parameters
#------------------------------------------------

variable "name" {
  description = "Name of EMR cluster"
}

variable "vpc_id" {
  description = "VPC ID to place cluster"
}

variable "subnet_id" {
  description = "VPC subnet ID to place cluster"
}

variable "key_name" {
  description = "Keypair name for SSH access"
}

variable "release_label" {
  description = "EMR release label"
}

variable "applications" {
  description = "List of applications to configure"
  type        = "list"
  default     = []
}

variable "instance_groups" {
  description = "List of instance group maps"
  type        = "list"
  default     = []
}

#------------------------------------------------
# Optional parameters (with reasonable defaults)
#------------------------------------------------

variable "configurations" {
  description = "JSON string of configurations to apply during bootstrap"
  default     = ""
}

variable "bootstrap_actions" {
  description = "Bootstrap actions to be ran before Hadoop is started"
  type        = "list"
  default     = []
}

variable "log_uri" {
  description = "S3 path to write log files. If no value is provided, logs are not created"
  default     = ""
}

variable "iam_service_role_policy" {
  description = "Inline IAM policy document to attach to EMR service role in lieu of default managed policy"
  default     = ""
}

variable "iam_ec2_instance_policy" {
  description = "Inline IAM policy document to attach to EMR EC2 instance role in lieu of default managed policy"
  default     = ""
}

variable "keep_job_flow_alive_when_no_steps" {
  description = "Whether to keep cluster alive when no steps remain"
  default     = true
}

variable "tags" {
  description = "Additional tags"
  default     = {}
  type        = "map"
}

variable "additional_master_security_group_ids" {
  description = "Additional security group IDs to apply to master"
  type        = "list"
  default     = []
}

variable "additional_slave_security_group_ids" {
  description = "Additional security group IDs to apply to slaves"
  type        = "list"
  default     = []
}

variable "allowed_inbound_cidr_blocks" {
  description = "CIDR blocks to have management UI access to cluster"
  type        = "list"
  default     = []
}

variable "allowed_inbound_security_group_ids" {
  description = "Security group IDs to have management UI access to cluster"
  type        = "list"
  default     = []
}

variable "allowed_ssh_cidr_blocks" {
  description = "CIDR blocks to have SSH access to the cluster"
  type        = "list"
  default     = []
}

variable "allowed_ssh_security_group_ids" {
  description = "Security group IDs to have SSH access to the cluster"
  type        = "list"
  default     = []
}
