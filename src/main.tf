locals {
  vpc_id = element(split("/", var.network.data.infrastructure.arn), 1)
  mysql = {
    protocol = "tcp"
    port     = 3306
  }
}

resource "random_password" "root_password" {
  length  = 10
  special = false
}

resource "random_id" "snapshot_identifier" {
  byte_length = 4
}

resource "aws_db_instance" "main" {
  identifier                  = var.md_metadata.name_prefix
  engine                      = "mysql"
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = true

  engine_version = var.database.engine_version
  username       = var.database.username
  password       = random_password.root_password.result
  instance_class = var.database.instance_class

  publicly_accessible = false
  port                = local.mysql.port

  allocated_storage     = var.storage.allocated
  max_allocated_storage = var.storage.max_allocated
  storage_type          = var.storage.type
  iops                  = lookup(var.storage, "iops", null)

  # TODO: disk encryption if storage_encrypted is set to true and a kms key is used, will it use the kms key
  # is this field even needed then?
  storage_encrypted = true
  kms_key_id        = aws_kms_key.mysql_encryption.arn

  # TODO: can we enabled this w/o requiring IAM (ie, using mysql pw)
  # iam_database_authentication_enabled = var.iam_database_authentication_enabled

  # TODO: accept vpc_security_group_ids
  # vpc_security_group_ids              = compact(concat(aws_security_group.main.*.id, var.vpc_security_group_ids))  
  vpc_security_group_ids = [aws_security_group.main.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  # parameter_group_name   = var.parameter_group_name
  # option_group_name      = var.option_group_name

  # availability_zone   = var.availability_zone
  # multi_az            = var.multi_az

  # apply_immediately           = var.apply_immediately
  # maintenance_window          = var.maintenance_window

  # replicate_source_db     = var.replicate_source_db
  # replica_mode            = var.replica_mode

  # performance_insights_enabled          = var.performance_insights_enabled
  # performance_insights_retention_period = var.performance_insights_enabled ? var.performance_insights_retention_period : null
  # performance_insights_kms_key_id       = var.performance_insights_enabled ? var.performance_insights_kms_key_id : null  

  # monitoring_interval     = var.monitoring_interval
  # monitoring_role_arn     = var.monitoring_interval > 0 ? local.monitoring_role_arn : null
  # enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  # audit, error, general, slowquery

  copy_tags_to_snapshot     = true
  deletion_protection       = var.database.deletion_protection
  skip_final_snapshot       = var.backup.skip_final_snapshot
  final_snapshot_identifier = var.backup.skip_final_snapshot ? null : "${var.md_metadata.name_prefix}-${element(concat(random_id.snapshot_identifier.*.hex, [""]), 0)}"

  # backup_retention_period = var.backup_retention_period
  # backup_window           = var.backup_window  
  # delete_automated_backups = var.delete_automated_backups

  lifecycle {
    ignore_changes = [
      latest_restorable_time
    ]
  }
}

resource "aws_db_subnet_group" "main" {
  name        = var.md_metadata.name_prefix
  description = "For RDS MySQL cluster ${var.md_metadata.name_prefix}"
  subnet_ids  = [for subnet in var.network.data.infrastructure.private_subnets : element(split("/", subnet["arn"]), 1)]
}

resource "aws_kms_key" "mysql_encryption" {
  description             = "MySQL Encryption Key for ${var.md_metadata.name_prefix}"
  deletion_window_in_days = 30
  # policy                  = data.aws_iam_policy_document.flow_log_encryption_key_policy[each.key].json  
  # multi_region = ?
  # enable_key_rotation = ?
}

resource "aws_kms_alias" "mysql_encryption" {
  name          = "alias/${var.md_metadata.name_prefix}-mysql-encryption"
  target_key_id = aws_kms_key.mysql_encryption.key_id
}

resource "aws_security_group" "main" {
  vpc_id      = local.vpc_id
  name_prefix = "${var.md_metadata.name_prefix}-"
  description = "Control traffic to/from RDS MySQL ${var.md_metadata.name_prefix}"
}

# TODO: Remove this once we have application bundles working.
resource "aws_security_group_rule" "vpc_ingress" {
  count       = var.networking.allow_vpc_access ? 1 : 0
  description = "From allowed CIDRs"
  type        = "ingress"
  from_port   = local.mysql.port
  to_port     = local.mysql.port
  protocol    = local.mysql.protocol
  cidr_blocks = [var.network.data.infrastructure.cidr]

  security_group_id = aws_security_group.main.id
}

output "mysql" {
  value     = aws_db_instance.main
  sensitive = true
}
