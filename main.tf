#
# EMR cluster resource
#
resource "aws_emr_cluster" "cluster" {
  name                              = "${var.name}"
  release_label                     = "${var.release_label}"
  service_role                      = "${aws_iam_role.emr_service_role.arn}"
  applications                      = "${var.applications}"
  instance_group                    = ["${var.instance_groups}"]
  bootstrap_action                  = ["${var.bootstrap_actions}"]
  log_uri                           = "${var.log_uri}"
  configurations                    = "${var.configurations}"
  keep_job_flow_alive_when_no_steps = "${var.keep_job_flow_alive_when_no_steps}"
  security_configuration            = "${var.security_configuration}"
  autoscaling_role                  = "${aws_iam_role.emr_autoscaling_role.arn}"
  ebs_root_volume_size              = "${var.ebs_root_volume_size}"

  ec2_attributes {
    key_name                          = "${var.key_name}"
    subnet_id                         = "${var.subnet_id}"
    emr_managed_master_security_group = "${aws_security_group.emr_master.id}"
    emr_managed_slave_security_group  = "${aws_security_group.emr_slave.id}"
    additional_master_security_groups = "${join(",", var.additional_master_security_group_ids)}"
    additional_slave_security_groups  = "${join(",", var.additional_slave_security_group_ids)}"
    service_access_security_group     = "${aws_security_group.emr_service_access.id}"
    instance_profile                  = "${aws_iam_instance_profile.emr_ec2_instance_role.arn}"
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
# IAM resources for EMR service role
#
data "aws_iam_policy_document" "emr_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["elasticmapreduce.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "emr_service_role" {
  name               = "EMR_${var.name}_Service_Role"
  assume_role_policy = "${data.aws_iam_policy_document.emr_assume_role.json}"
}

resource "aws_iam_role_policy" "emr_service_role" {
  count       = "${length(var.iam_service_role_policy) > 0 ? 1 : 0}"
  name_prefix = "EMRServicePolicy"
  role        = "${aws_iam_role.emr_service_role.id}"
  policy      = "${var.iam_service_role_policy}"
}

resource "aws_iam_role_policy_attachment" "emr_service_role" {
  count      = "${length(var.iam_service_role_policy) > 0 ? 0 : 1}"
  role       = "${aws_iam_role.emr_service_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
}

#
# IAM resources for EMR autoscaling role
#
data "aws_iam_policy_document" "emr_autoscaling_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = [
        "application-autoscaling.amazonaws.com",
        "elasticmapreduce.amazonaws.com"
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "emr_autoscaling_role" {
  name               = "EMR_${var.name}_Autoscaling_Role"
  assume_role_policy = "${data.aws_iam_policy_document.emr_autoscaling_assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "emr_autoscaling_role" {
  role       = "${aws_iam_role.emr_autoscaling_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforAutoScalingRole"
}

#
# IAM resources for EMR EC2 instances
#
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "emr_ec2_instance_role" {
  name               = "EMR_${var.name}_EC2_Role"
  assume_role_policy = "${data.aws_iam_policy_document.ec2_assume_role.json}"
}

resource "aws_iam_role_policy" "ec2_instance_role" {
  count       = "${length(var.iam_ec2_instance_policy) > 0 ? 1 : 0}"
  name_prefix = "EMRforEC2Policy"
  role        = "${aws_iam_role.emr_ec2_instance_role.id}"
  policy      = "${var.iam_ec2_instance_policy}"
}

resource "aws_iam_role_policy_attachment" "emr_ec2_instance_role" {
  count      = "${length(var.iam_ec2_instance_policy) > 0 ? 0 : 1}"
  role       = "${aws_iam_role.emr_ec2_instance_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforEC2Role"
}

resource "aws_iam_instance_profile" "emr_ec2_instance_role" {
  name = "${aws_iam_role.emr_ec2_instance_role.name}"
  role = "${aws_iam_role.emr_ec2_instance_role.name}"
}
