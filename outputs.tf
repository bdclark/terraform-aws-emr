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

output "service_role_name" {
  description = "Cluster service role name"
  value       = "${aws_iam_role.emr_service_role.name}"
}

output "ec2_instance_role_name" {
  description = "Cluster EC2 instance role name"
  value       = "${aws_iam_role.emr_ec2_instance_role.name}"
}
