# AWS EMR Security Group Rules Module

A Terraform module to create security group rules to manage inbound SSH and/or
inbound access to (all of) the various web dashboards of EMR services.

## Variables

Variable                              | Description                                                     | Default
--------------------------------------|-----------------------------------------------------------------|-----------
`master_security_group_id`            | security group ID of EMR managed master security group          | _required_
`slave_security_group_id`             | security group ID of EMR managed slave security group           | _required_
`allowed_inbound_cidr_blocks`         | list of CIDR blocks to provide inbound dashboard access         | `[]`
`allowed_inbound_security_group_ids`  | list of security group IDs to provide inbound dashboard access  | `[]`
`allowed_ssh_cidr_blocks`             | list of CIDR blocks allowed to provide inbound SSH access       | `[]`
`allowed_ssh_security_group_ids`      | list of security group IDs to provide inbound SSH access        | `[]`

# Outputs
See `outputs.tf` for a list and description of all outputs provided by this
module.
