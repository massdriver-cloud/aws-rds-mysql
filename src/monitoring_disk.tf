locals {
  burst_balance_threshold    = 100
  disk_queue_depth_threshold = 64

  instance_allocated_storage_in_gib   = var.storage.max_allocated > 0 ? var.storage.max_allocated : var.storage.allocated
  instance_allocated_storage_in_bytes = local.instance_allocated_storage_in_gib * 1073741824

  free_storage_space_threshold_percent = 0.1
  free_storage_space_threshold         = local.free_storage_space_threshold_percent * local.instance_allocated_storage_in_bytes
}

module "primary_disk_queue_depth" {
  source = "github.com/massdriver-cloud/terraform-modules//aws-cloudwatch-alarm?ref=3ec7921"

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
  source = "github.com/massdriver-cloud/terraform-modules//aws-cloudwatch-alarm?ref=3ec7921"

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

module "primary_burst_balance" {
  source = "github.com/massdriver-cloud/terraform-modules//aws-cloudwatch-alarm?ref=3ec7921"

  depends_on = [
    aws_db_instance.main
  ]

  md_metadata         = var.md_metadata
  message             = "RDS MySQL ${aws_db_instance.main.identifier}: Average EBS Burst balance < ${local.burst_balance_threshold}"
  alarm_name          = "${aws_db_instance.main.identifier}-lowEBSBurstBalance"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "BurstBalance"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = local.burst_balance_threshold

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.main.id
  }
}
