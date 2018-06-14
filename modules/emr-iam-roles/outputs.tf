output "service_role_arn" {
  value = "${aws_iam_role.emr_service_role.arn}"
}

output "service_role_name" {
  value = "${aws_iam_role.emr_service_role.name}"
}

output "service_role_id" {
  value = "${aws_iam_role.emr_service_role.id}"
}

output "ec2_instance_role_arn" {
  value = "${aws_iam_role.emr_ec2_instance_role.arn}"
}

output "ec2_instance_role_name" {
  value = "${aws_iam_role.emr_ec2_instance_role.name}"
}

output "ec2_instance_role_id" {
  value = "${aws_iam_role.emr_ec2_instance_role.id}"
}

output "autoscaling_role_arn" {
  value = "${aws_iam_role.emr_autoscaling_role.arn}"
}

output "autoscaling_role_name" {
  value = "${aws_iam_role.emr_autoscaling_role.name}"
}

output "autoscaling_role_id" {
  value = "${aws_iam_role.emr_autoscaling_role.id}"
}
