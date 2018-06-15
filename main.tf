#
# EMR cluster resource
#
resource "aws_emr_cluster" "cluster" {
  name                              = "${var.name}"
  release_label                     = "${var.release_label}"
  service_role                      = "${module.iam_roles.service_role_arn}"
  applications                      = "${var.applications}"
  instance_group                    = ["${var.instance_groups}"]
  bootstrap_action                  = ["${var.bootstrap_actions}"]
  log_uri                           = "${var.log_uri}"
  configurations                    = "${var.configurations}"
  keep_job_flow_alive_when_no_steps = "${var.keep_job_flow_alive_when_no_steps}"
  security_configuration            = "${var.security_configuration}"
  autoscaling_role                  = "${module.iam_roles.autoscaling_role_arn}"
  ebs_root_volume_size              = "${var.ebs_root_volume_size}"

  ec2_attributes {
    key_name                          = "${var.key_name}"
    subnet_id                         = "${var.subnet_id}"
    emr_managed_master_security_group = "${aws_security_group.emr_master.id}"
    emr_managed_slave_security_group  = "${aws_security_group.emr_slave.id}"
    additional_master_security_groups = "${join(",", var.additional_master_security_group_ids)}"
    additional_slave_security_groups  = "${join(",", var.additional_slave_security_group_ids)}"
    service_access_security_group     = "${aws_security_group.emr_service_access.id}"
    instance_profile                  = "${module.iam_roles.ec2_instance_role_arn}"
  }

  tags = "${merge(map("Name", var.name), var.tags)}"
}

#
# EMR Managed Security group resources
#
resource "aws_security_group" "emr_master" {
  vpc_id                 = "${var.vpc_id}"
  name_prefix            = "emr_master_${var.name}"
  description            = "Master group for Elastic MapReduce"
  revoke_rules_on_delete = true

  tags {
    Name = "emr_master_${var.name}"
  }
}

resource "aws_security_group" "emr_slave" {
  vpc_id                 = "${var.vpc_id}"
  name_prefix            = "emr_slave_${var.name}"
  description            = "Slave group for Elastic MapReduce"
  revoke_rules_on_delete = true

  tags {
    Name = "emr_slave_${var.name}"
  }
}

resource "aws_security_group" "emr_service_access" {
  vpc_id                 = "${var.vpc_id}"
  name_prefix            = "emr_service_${var.name}"
  description            = "Service access group for Elastic MapReduce"
  revoke_rules_on_delete = true

  tags {
    Name = "emr_service_access_${var.name}"
  }
}

#
# Security group rules for EMR cluster management and UI access
#
module "security_group_rules" {
  source = "modules/emr-security-group-rules"

  master_security_group_id           = "${aws_security_group.emr_master.id}"
  slave_security_group_id            = "${aws_security_group.emr_slave.id}"
  allowed_inbound_cidr_blocks        = "${var.allowed_inbound_cidr_blocks}"
  allowed_inbound_security_group_ids = "${var.allowed_inbound_security_group_ids}"
  allowed_ssh_cidr_blocks            = "${var.allowed_ssh_cidr_blocks}"
  allowed_ssh_security_group_ids     = "${var.allowed_ssh_security_group_ids}"
}

#
# IAM roles for EMR service, EC2 instances, and AutoScaling
#
module "iam_roles" {
  source = "modules/emr-iam-roles"

  name                     = "${var.name}"
  service_role_policy      = "${var.service_role_policy}"
  ec2_instance_role_policy = "${var.ec2_instance_role_policy}"
}
