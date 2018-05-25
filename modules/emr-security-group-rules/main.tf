#
# Security group rules for outbound traffic
#
resource "aws_security_group_rule" "emr_master_allow_all_outbound" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${var.master_security_group_id}"
}

resource "aws_security_group_rule" "emr_slave_allow_all_outbound" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${var.slave_security_group_id}"
}

#
# Security group rules for SSH
#
resource "aws_security_group_rule" "allow_ssh_inbound_cidr" {
  count       = "${length(var.allowed_ssh_cidr_blocks) >= 1 ? 1 : 0}"
  description = "SSH access"
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_ssh_cidr_blocks}"]

  security_group_id = "${var.master_security_group_id}"
}

resource "aws_security_group_rule" "allow_ssh_inbound_security_group_ids" {
  count                    = "${length(var.allowed_ssh_security_group_ids)}"
  description              = "SSH access"
  type                     = "ingress"
  from_port                = 8088
  to_port                  = 8088
  protocol                 = "tcp"
  source_security_group_id = "${element(var.allowed_inbound_security_group_ids, count.index)}"

  security_group_id = "${var.master_security_group_id}"
}

#
# Security group rules for YARN
#
resource "aws_security_group_rule" "allow_yarn_resourcemanager_inbound_cidr" {
  count       = "${length(var.allowed_inbound_cidr_blocks) >= 1 ? 1 : 0}"
  description = "YARN ResourceManager access"
  type        = "ingress"
  from_port   = 8088
  to_port     = 8088
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${var.master_security_group_id}"
}

resource "aws_security_group_rule" "allow_yarn_resourcemanager_inbound_security_group_ids" {
  count                    = "${length(var.allowed_inbound_security_group_ids)}"
  description              = "YARN ResourceManager access"
  type                     = "ingress"
  from_port                = 8088
  to_port                  = 8088
  protocol                 = "tcp"
  source_security_group_id = "${element(var.allowed_inbound_security_group_ids, count.index)}"

  security_group_id = "${var.master_security_group_id}"
}

resource "aws_security_group_rule" "allow_yarn_nodemanager_inbound_cidr" {
  count       = "${length(var.allowed_inbound_cidr_blocks) >= 1 ? 1 : 0}"
  description = "YARN NodeManager access"
  type        = "ingress"
  from_port   = 8042
  to_port     = 8042
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${var.slave_security_group_id}"
}

resource "aws_security_group_rule" "allow_yarn_nodemanager_inbound_security_group_ids" {
  count                    = "${length(var.allowed_inbound_security_group_ids)}"
  description              = "YARN NodeManager access"
  type                     = "ingress"
  from_port                = 8042
  to_port                  = 8042
  protocol                 = "tcp"
  source_security_group_id = "${element(var.allowed_inbound_security_group_ids, count.index)}"

  security_group_id = "${var.slave_security_group_id}"
}

#
# Security group rules for HDFS
#
resource "aws_security_group_rule" "allow_hdfs_namenode_inbound_cidr" {
  count       = "${length(var.allowed_inbound_cidr_blocks) >= 1 ? 1 : 0}"
  description = "HDFS NameNode access"
  type        = "ingress"
  from_port   = 50070
  to_port     = 50070
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${var.master_security_group_id}"
}

resource "aws_security_group_rule" "allow_hdfs_namenode_inbound_security_group_ids" {
  count                    = "${length(var.allowed_inbound_security_group_ids)}"
  description              = "HDFS NameNode access"
  type                     = "ingress"
  from_port                = 50070
  to_port                  = 50070
  protocol                 = "tcp"
  source_security_group_id = "${element(var.allowed_inbound_security_group_ids, count.index)}"

  security_group_id = "${var.master_security_group_id}"
}

resource "aws_security_group_rule" "allow_hdfs_datanode_inbound_cidr" {
  count       = "${length(var.allowed_inbound_cidr_blocks) >= 1 ? 1 : 0}"
  description = "HDFS DataNode access"
  type        = "ingress"
  from_port   = 50075
  to_port     = 50075
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${var.slave_security_group_id}"
}

resource "aws_security_group_rule" "allow_hdfs_datanode_inbound_security_group_ids" {
  count                    = "${length(var.allowed_inbound_security_group_ids)}"
  description              = "HDFS DataNode access"
  type                     = "ingress"
  from_port                = 50075
  to_port                  = 50075
  protocol                 = "tcp"
  source_security_group_id = "${element(var.allowed_inbound_security_group_ids, count.index)}"

  security_group_id = "${var.slave_security_group_id}"
}

#
# Security group rules for Spark
#
resource "aws_security_group_rule" "allow_spark_inbound_cidr" {
  count       = "${length(var.allowed_inbound_cidr_blocks) >= 1 ? 1 : 0}"
  description = "Spark access"
  type        = "ingress"
  from_port   = 18080
  to_port     = 18080
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${var.master_security_group_id}"
}

resource "aws_security_group_rule" "allow_spark_inbound_security_group_ids" {
  count                    = "${length(var.allowed_inbound_security_group_ids)}"
  description              = "Spark access"
  type                     = "ingress"
  from_port                = 18080
  to_port                  = 18080
  protocol                 = "tcp"
  source_security_group_id = "${element(var.allowed_inbound_security_group_ids, count.index)}"

  security_group_id = "${var.master_security_group_id}"
}

#
# Security group rules for Zeppelin
#
resource "aws_security_group_rule" "allow_zeppelin_inbound_cidr" {
  count       = "${length(var.allowed_inbound_cidr_blocks) >= 1 ? 1 : 0}"
  description = "Zeppelin access"
  type        = "ingress"
  from_port   = 8890
  to_port     = 8890
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${var.master_security_group_id}"
}

resource "aws_security_group_rule" "allow_zeppelin_inbound_security_group_ids" {
  count                    = "${length(var.allowed_inbound_security_group_ids)}"
  description              = "Zeppelin access"
  type                     = "ingress"
  from_port                = 8890
  to_port                  = 8890
  protocol                 = "tcp"
  source_security_group_id = "${element(var.allowed_inbound_security_group_ids, count.index)}"

  security_group_id = "${var.master_security_group_id}"
}

#
# Security group rules for Hue
#
resource "aws_security_group_rule" "allow_hue_inbound_cidr" {
  count       = "${length(var.allowed_inbound_cidr_blocks) >= 1 ? 1 : 0}"
  description = "Hue access"
  type        = "ingress"
  from_port   = 8888
  to_port     = 8888
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${var.master_security_group_id}"
}

resource "aws_security_group_rule" "allow_hue_inbound_security_group_ids" {
  count                    = "${length(var.allowed_inbound_security_group_ids)}"
  description              = "Hue access"
  type                     = "ingress"
  from_port                = 8888
  to_port                  = 8888
  protocol                 = "tcp"
  source_security_group_id = "${element(var.allowed_inbound_security_group_ids, count.index)}"

  security_group_id = "${var.master_security_group_id}"
}

#
# Security group rules for Ganglia
#
resource "aws_security_group_rule" "allow_ganglia_inbound_cidr" {
  count       = "${length(var.allowed_inbound_cidr_blocks) >= 1 ? 1 : 0}"
  description = "Ganglia access"
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${var.master_security_group_id}"
}

resource "aws_security_group_rule" "allow_ganglia_inbound_security_group_ids" {
  count                    = "${length(var.allowed_inbound_security_group_ids)}"
  description              = "Ganglia access"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${element(var.allowed_inbound_security_group_ids, count.index)}"

  security_group_id = "${var.master_security_group_id}"
}

#
# Security group rules for HBase UI
#
resource "aws_security_group_rule" "allow_hbase_inbound_cidr" {
  count       = "${length(var.allowed_inbound_cidr_blocks) >= 1 ? 1 : 0}"
  description = "HBase access"
  type        = "ingress"
  from_port   = 16010
  to_port     = 16010
  protocol    = "tcp"
  cidr_blocks = ["${var.allowed_inbound_cidr_blocks}"]

  security_group_id = "${var.master_security_group_id}"
}

resource "aws_security_group_rule" "allow_hbase_inbound_security_group_ids" {
  count                    = "${length(var.allowed_inbound_security_group_ids)}"
  description              = "HBase access"
  type                     = "ingress"
  from_port                = 16010
  to_port                  = 16010
  protocol                 = "tcp"
  source_security_group_id = "${element(var.allowed_inbound_security_group_ids, count.index)}"

  security_group_id = "${var.master_security_group_id}"
}
