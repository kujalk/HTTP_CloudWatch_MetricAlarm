resource "aws_sns_topic" "alarm" {
  name = "${var.Project_Name}-Alarm-Topic"
}

resource "aws_sns_topic_subscription" "alarm_subscription" {
  topic_arn = aws_sns_topic.alarm.arn
  protocol  = "email"
  endpoint  = var.Email
}