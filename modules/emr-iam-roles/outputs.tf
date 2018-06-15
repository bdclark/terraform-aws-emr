output "service_role_arn" {
  description = "EMR IAM service role ARN"
  value       = "${aws_iam_role.service_role.arn}"
}

output "service_role_name" {
  description = "EMR IAM service role name"
  value       = "${aws_iam_role.service_role.name}"
}

output "service_role_id" {
  description = "EMR IAM service role ID"
  value       = "${aws_iam_role.service_role.id}"
}

output "ec2_instance_role_arn" {
  description = "EMR IAM EC2 instance role ARN"
  value       = "${aws_iam_role.instance_role.arn}"
}

output "ec2_instance_role_name" {
  description = "EMR IAM EC2 instance role name"
  value       = "${aws_iam_role.instance_role.name}"
}

output "ec2_instance_role_id" {
  description = "EMR IAM EC2 instance role ID"
  value       = "${aws_iam_role.instance_role.id}"
}

output "autoscaling_role_arn" {
  description = "EMR IAM AutoScaling role ARN"
  value       = "${aws_iam_role.autoscaling_role.arn}"
}

output "autoscaling_role_name" {
  description = "EMR IAM AutoScaling role name"
  value       = "${aws_iam_role.autoscaling_role.name}"
}

output "autoscaling_role_id" {
  description = "EMR IAM AutoScaling role ID"
  value       = "${aws_iam_role.autoscaling_role.id}"
}
