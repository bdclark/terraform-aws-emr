# AWS EMR IAM Roles Module

A terraform module to create EMR service role, EMR EC2 instance role, and EMR
AutoScaling role for use with an AWS EMR cluster.

# Variables

Variable                           | Description                                                                                               | Default
-----------------------------------|-----------------------------------------------------------------------------------------------------------|-----------
`name`                             | name to be applied to IAM roles (typically cluster name)                                                  | _required_
`use_default_service_role_policy`  | whether to attach the AWS managed `AmazonElasticMapReduceRole` policy to the EMR service role             | `true`
`use_default_instance_role_policy` | whether to attach the AWS managed `AmazonElasticMapReduceforEC2Role` policy to the EMR EC2 instance role  | `true`
`service_role_policy`              | inline IAM policy document to attach to EMR service role                                                  | `""`
`instance_role_policy`             | Inline IAM policy document to attach to EMR EC2 instance role                                             | `""`

Unless `use_default_service_role_policy` and/or `use_default_instance_role_policy`
are explicitly set to `false`, the default AWS-managed IAM policies for EMR will
be applied to their respective roles. In many production scenarios, the permissions
allowed by the managed policies are too liberal. To limit permissions, set one
or both of the aforementioned variables to `false` and supply your own policy
document(s) to be applied directly to the respective service and/or EC2 instance roles.

This module does not currently accept a custom policy for the EMR AutoScaling
role it creates. Instead, it attaches the default AWS-managed policy
`AmazonElasticMapReduceforAutoScalingRole`.

# Outputs
See `outputs.tf` for a list and description of all outputs provided by this
module.
