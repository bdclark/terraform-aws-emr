output "id" {
  description = "Cluster ID"
  value       = "${aws_emr_cluster.cluster.id}"
}

output "name" {
  description = "Cluster name"
  value       = "${aws_emr_cluster.cluster.name}"
}

output "master_public_dns" {
  description = "Public DNS name of master node"
  value       = "${aws_emr_cluster.cluster.master_public_dns}"
}

output "master_security_group_id" {
  description = "Master managed security group ID"
  value       = "${aws_security_group.emr_master.id}"
}

output "slave_security_group_id" {
  description = "Slave managed security group ID"
  value       = "${aws_security_group.emr_slave.id}"
}

output "service_role_arn" {
  description = "Cluster IAM service role ARN"
  value       = "${module.iam_roles.service_role_arn}"
}

output "service_role_name" {
  description = "Cluster IAM service role name"
  value       = "${module.iam_roles.service_role_name}"
}

output "service_role_id" {
  description = "Cluster IAM service role ID"
  value       = "${module.iam_roles.service_role_id}"
}

output "ec2_instance_role_arn" {
  description = "Cluster IAM EC2 instance role ARN"
  value       = "${module.iam_roles.ec2_instance_role_arn}"
}

output "ec2_instance_role_name" {
  description = "Cluster IAM EC2 instance role name"
  value       = "${module.iam_roles.ec2_instance_role_name}"
}

output "ec2_instance_role_id" {
  description = "Cluster IAM EC2 instance role ID"
  value       = "${module.iam_roles.ec2_instance_role_id}"
}

output "autoscaling_role_arn" {
  description = "Cluster IAM AutoScaling role ARN"
  value       = "${module.iam_roles.autoscaling_role_arn}"
}

output "autoscaling_role_name" {
  description = "Cluster IAM AutoScaling role name"
  value       = "${module.iam_roles.autoscaling_role_name}"
}

output "autoscaling_role_id" {
  description = "Cluster IAM AutoScaling role ID"
  value       = "${module.iam_roles.autoscaling_role_id}"
}
