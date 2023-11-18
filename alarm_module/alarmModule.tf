resource "aws_cloudwatch_metric_alarm" "threshold" {
  alarm_name  = "${var.kandidat}-violation-threshold"
  namespace   = var.kandidat
  metric_name = "violation_count.value"

  comparison_operator = "GreaterThanThreshold"
  threshold           = 5
  evaluation_periods  = "2"
  period              = "60"
  statistic           = "Maximum"

  alarm_description = "This alarm goes off if there are more than 5 PPE violation!"
  alarm_actions     = [aws_sns_topic.user_updates.arn]
}

resource "aws_sns_topic" "user_updates" {
  name = "${var.kandidat}-alarm-topic"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}