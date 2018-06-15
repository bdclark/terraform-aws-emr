# AWS EMR IAM Roles Module

A terraform module to create EMR service role, EMR EC2 instance role, and EMR
AutoScaling role for use with an AWS EMR cluster.

# Variables

Variable                    | Description                                                   | Default
----------------------------|---------------------------------------------------------------|-----------
`name`                      | name to be applied to IAM roles (typically cluster name)      | _required_
`service_role_policy`       | inline IAM policy document to attach to EMR service role      | `""`
`ec2_instance_role_policy`  | Inline IAM policy document to attach to EMR EC2 instance role | `""`

If specific `service_role_policy` or `ec2_instance_role_policy` JSON document(s)
are not provided, the default AWS managed policies for the given role(s) will be
attached (`AmazonElasticMapReduceRole` and/or `AmazonElasticMapReduceforEC2Role`,
respectively).

This module does not currently accept a custom policy for the EMR AutoScaling
role it creates. Instead, it attaches the default AWS managed policy
`AmazonElasticMapReduceforAutoScalingRole`.

# Outputs
See `outputs.tf` for a list and description of all outputs provided by this
module.
