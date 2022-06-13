locals {
  cpu_utilization_threshold    = 90
  cpu_credit_balance_threshold = 100
}

module "primary_cpu_utilization" {
  source = "github.com/massdriver-cloud/terraform-modules//aws-cloudwatch-alarm?ref=3ec7921"

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

module "primary_cpu_credit_balance" {
  source = "github.com/massdriver-cloud/terraform-modules//aws-cloudwatch-alarm?ref=3ec7921"
  count  = length(regexall("(t2|t3)", var.database.instance_class)) > 0 ? 1 : 0

  depends_on = [
    aws_db_instance.main
  ]

  md_metadata         = var.md_metadata
  message             = "RDS MySQL ${aws_db_instance.main.identifier}: Average CPU Credit Balance < ${local.cpu_credit_balance_threshold}"
  alarm_name          = "${aws_db_instance.main.identifier}-lowCPUCreditBalance"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUCreditBalance"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = local.cpu_credit_balance_threshold

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.main.id
  }
}
