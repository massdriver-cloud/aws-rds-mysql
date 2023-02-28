module "alarm_channel" {
  source      = "github.com/massdriver-cloud/terraform-modules//aws/alarm-channel?ref=343d3e4"
  md_metadata = var.md_metadata
}

// CPU
locals {
  cpu_utilization_threshold    = 90
  cpu_credit_balance_threshold = 100
}

module "primary_cpu_utilization" {
  source        = "github.com/massdriver-cloud/terraform-modules//aws/cloudwatch-alarm?ref=343d3e4"
  sns_topic_arn = module.alarm_channel.arn
  display_name  = "Primary CPU Utilization"
  depends_on = [
    aws_db_instance.main
  ]

  md_metadata         = var.md_metadata
  message             = "RDS MySQL ${aws_db_instance.main.identifier}:  AverageCPU Utilization > ${local.cpu_utilization_threshold}%"
  alarm_name          = "${aws_db_instance.main.identifier}-highCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = local.cpu_utilization_threshold

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.main.id
  }
}

// Disk
locals {
  burst_balance_threshold    = 100
  disk_queue_depth_threshold = 64

  instance_allocated_storage_in_gib   = var.storage.max_allocated > 0 ? var.storage.max_allocated : var.storage.allocated
  instance_allocated_storage_in_bytes = local.instance_allocated_storage_in_gib * 1073741824

  free_storage_space_threshold_percent = 0.1
  free_storage_space_threshold         = local.free_storage_space_threshold_percent * local.instance_allocated_storage_in_bytes
}

module "primary_disk_queue_depth" {
  source        = "github.com/massdriver-cloud/terraform-modules//aws/cloudwatch-alarm?ref=343d3e4"
  sns_topic_arn = module.alarm_channel.arn
  display_name  = "Primary Disk Queue Depth"
  depends_on = [
    aws_db_instance.main
  ]

  md_metadata         = var.md_metadata
  message             = "RDS MySQL ${aws_db_instance.main.identifier}: Average disk queue depth > ${local.disk_queue_depth_threshold}"
  alarm_name          = "${aws_db_instance.main.identifier}-highDiskQueueDepth"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "DiskQueueDepth"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = local.disk_queue_depth_threshold

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.main.id
  }
}

module "primary_free_storage_space" {
  source        = "github.com/massdriver-cloud/terraform-modules//aws/cloudwatch-alarm?ref=343d3e4"
  sns_topic_arn = module.alarm_channel.arn
  display_name  = "Primary Free Storage"
  depends_on = [
    aws_db_instance.main
  ]

  md_metadata         = var.md_metadata
  message             = "RDS MySQL ${aws_db_instance.main.identifier}: Average free storage space < ${local.free_storage_space_threshold} bytes"
  alarm_name          = "${aws_db_instance.main.identifier}-lowFreeStorageSpace"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = local.free_storage_space_threshold

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.main.id
  }
}

// Memory
locals {
  instance_memory_size_in_gib   = local.instance_memory_map[var.database.instance_class]
  instance_memory_size_in_bytes = local.instance_memory_size_in_gib * 1073741824

  freeable_memory_threshold_percent = 0.1
  freeable_memory_threshold         = local.freeable_memory_threshold_percent * local.instance_memory_size_in_bytes

  swap_usage_threshold_percent = 0.1
  swap_usage_threshold         = local.swap_usage_threshold_percent * local.instance_memory_size_in_bytes
}

module "primary_freeable_memory" {
  source        = "github.com/massdriver-cloud/terraform-modules//aws/cloudwatch-alarm?ref=343d3e4"
  sns_topic_arn = module.alarm_channel.arn
  display_name  = "Primary Freeable Memory"
  depends_on = [
    aws_db_instance.main
  ]

  md_metadata         = var.md_metadata
  message             = "RDS MySQL ${aws_db_instance.main.identifier}: Average freeable memory < ${local.freeable_memory_threshold} bytes"
  alarm_name          = "${aws_db_instance.main.identifier}-lowFreeableMemory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = local.freeable_memory_threshold

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.main.id
  }
}

module "primary_swap_usage" {
  source        = "github.com/massdriver-cloud/terraform-modules//aws/cloudwatch-alarm?ref=343d3e4"
  sns_topic_arn = module.alarm_channel.arn
  display_name  = "Primary Swap Usage"
  depends_on = [
    aws_db_instance.main
  ]

  md_metadata         = var.md_metadata
  message             = "RDS MySQL ${aws_db_instance.main.identifier}: Average swap usage > ${local.swap_usage_threshold} bytes"
  alarm_name          = "${aws_db_instance.main.identifier}-highSwapUsage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "SwapUsage"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = local.swap_usage_threshold

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.main.id
  }
}
