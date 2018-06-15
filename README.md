# AWS EMR Terraform Module

A collection of Terraform modules for working with AWS EMR.

# Sub-Modules
The following sub-modules are available in the `modules` directory:

- [emr-iam-roles](modules/emr-iam-roles/README.md) - manages EMR IAM roles
- [emr-security-group-rules](modules/emr-security-group-rules/README.md) - manages
  security group rules to manage inbound SSH and/or
  inbound dashboard access to an EMR cluster.

# Root Module
The module in the root of this repo is a working example of how to use the
sub-modules in this repo, and is not recommended for use in a production
environment.
