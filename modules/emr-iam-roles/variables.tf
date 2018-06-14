variable "name" {
  description = "Name to be applied to IAM roles"
}

variable "service_role_policy" {
  description = "Inline IAM policy document to attach to EMR service role in lieu of default managed policy"
  default     = ""
}

variable "ec2_instance_role_policy" {
  description = "Inline IAM policy document to attach to EMR EC2 instance role in lieu of default managed policy"
  default     = ""
}
