

variable "name" {
  description = "Name of EMR cluster"
}

variable "vpc_id" {
  description = "VPC ID to place cluster"
}

variable "subnet_id" {
  description = "VPC subnet ID to place cluster"
}

variable "key_name" {
  description = "Keypair name for SSH access"
}

module "emr_cluster" {
  source = "../"

  name                        = "terraform-cluster"
  release_label               = "emr-5.13.0"
  vpc_id                      = "${var.vpc_id}"
  subnet_id                   = "${var.subnet_id}"
  key_name                    = "${var.key_name}"
  allowed_inbound_cidr_blocks = ["0.0.0.0/0"]
  allowed_ssh_cidr_blocks     = ["0.0.0.0/0"]

  applications = [
    "Spark",
    "Ganglia",
    "Zeppelin",
  ]

  instance_groups = [
    {
      name           = "MasterInstanceGroup"
      instance_role  = "MASTER"
      instance_type  = "m4.large"
      instance_count = 1
    },
    {
      name           = "CoreInstanceGroup"
      instance_role  = "CORE"
      instance_type  = "m4.large"
      instance_count = 2
      bid_price      = "0.30"
    },
  ]

  configurations = <<EOF
[
  {
    "classification":"emrfs-site",
    "properties": {
      "fs.s3.consistent.retryPeriodSeconds":"10",
      "fs.s3.consistent":"true",
      "fs.s3.consistent.retryCount":"5",
      "fs.s3.consistent.metadata.tableName":"EmrFSMetadata"
    },
  "configurations":[]
  },
  {
    "classification":"spark",
    "properties": {
      "maximizeResourceAllocation":"true"
    },
    "configurations":[]
  }
]
EOF

  tags = {
    Environment = "dev"
  }
}
