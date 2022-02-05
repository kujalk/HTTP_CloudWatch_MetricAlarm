resource "aws_cloudwatch_log_group" "web-logs" {
  name              = "httpd-logs"
  retention_in_days = 1

  tags = {
    Project = "${var.Project_Name}"
  }
}

resource "aws_cloudwatch_log_metric_filter" "metric" {
  name           = "${var.Project_Name}_HTTP_Count"
  pattern        = "[ip, user, username, timestamp, request, status_code = 2* || status_code = 3*, bytes]"
  log_group_name = aws_cloudwatch_log_group.web-logs.name

  metric_transformation {
    name          = "HTTPCount"
    namespace     = "WebServer"
    value         = "1"
    default_value = "0"
  }
}

resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name                = "${var.Project_Name}_Alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "HTTPCount"
  namespace                 = "WebServer"
  period                    = "60"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "This metric for monitoring HTTP count"
  alarm_actions             = [aws_sns_topic.alarm.arn]
  insufficient_data_actions = []
  treat_missing_data = "notBreaching"
}