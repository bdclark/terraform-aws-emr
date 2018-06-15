variable "name" {
  description = "Name to be applied to IAM roles"
}

variable "use_default_service_role_policy" {
  description = "Whether to attach the AWS managed AmazonElasticMapReduceRole policy to the EMR service role"
  default     = true
}

variable "use_default_instance_role_policy" {
  description = "Whether to attach the AWS managed AmazonElasticMapReduceforEC2Role policy to the EMR EC2 instance role"
  default     = true
}

variable "service_role_policy" {
  description = "Inline IAM policy document to attach to EMR service role in lieu of default managed policy"
  default     = ""
}

variable "instance_role_policy" {
  description = "Inline IAM policy document to attach to EMR EC2 instance role in lieu of default managed policy"
  default     = ""
}
