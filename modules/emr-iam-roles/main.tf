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

resource "aws_iam_role" "service_role" {
  name               = "${var.name}_EMRServiceRole"
  assume_role_policy = "${data.aws_iam_policy_document.emr_assume_role.json}"
}

resource "aws_iam_role_policy" "service_role" {
  count       = "${length(var.service_role_policy) > 0 ? 1 : 0}"
  name_prefix = "EMRServicePolicy"
  role        = "${aws_iam_role.service_role.id}"
  policy      = "${var.service_role_policy}"
}

resource "aws_iam_role_policy_attachment" "service_role" {
  count      = "${length(var.service_role_policy) > 0 ? 0 : 1}"
  role       = "${aws_iam_role.service_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
}

#
# IAM resources for EMR autoscaling role
#
data "aws_iam_policy_document" "emr_autoscaling_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "application-autoscaling.amazonaws.com",
        "elasticmapreduce.amazonaws.com",
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "autoscaling_role" {
  name               = "${var.name}_EMRAutoScalingRole"
  assume_role_policy = "${data.aws_iam_policy_document.emr_autoscaling_assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "autoscaling_role" {
  role       = "${aws_iam_role.autoscaling_role.name}"
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

resource "aws_iam_role" "ec2_instance_role" {
  name               = "${var.name}_EMRforEC2Role"
  assume_role_policy = "${data.aws_iam_policy_document.ec2_assume_role.json}"
}

resource "aws_iam_role_policy" "ec2_instance_role" {
  count       = "${length(var.ec2_instance_role_policy) > 0 ? 1 : 0}"
  name_prefix = "EMRforEC2Policy"
  role        = "${aws_iam_role.ec2_instance_role.id}"
  policy      = "${var.ec2_instance_role_policy}"
}

resource "aws_iam_role_policy_attachment" "ec2_instance_role" {
  count      = "${length(var.ec2_instance_role_policy) > 0 ? 0 : 1}"
  role       = "${aws_iam_role.ec2_instance_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforEC2Role"
}

resource "aws_iam_instance_profile" "ec2_instance_role" {
  name = "${aws_iam_role.ec2_instance_role.name}"
  role = "${aws_iam_role.ec2_instance_role.name}"
}
