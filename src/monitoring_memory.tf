locals {
  instance_memory_size_in_gib   = local.instance_memory_map[var.database.instance_class]
  instance_memory_size_in_bytes = local.instance_memory_size_in_gib * 1073741824

  freeable_memory_threshold_percent = 0.1
  freeable_memory_threshold         = local.freeable_memory_threshold_percent * local.instance_memory_size_in_bytes

  swap_usage_threshold_percent = 0.1
  swap_usage_threshold         = local.swap_usage_threshold_percent * local.instance_memory_size_in_bytes
}

module "primary_freeable_memory" {
  source = "github.com/massdriver-cloud/terraform-modules//aws-cloudwatch-alarm?ref=3ec7921"

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
  source = "github.com/massdriver-cloud/terraform-modules//aws-cloudwatch-alarm?ref=3ec7921"

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
