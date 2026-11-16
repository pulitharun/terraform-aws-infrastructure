
resource "aws_sns_topic" "cloudwatch_alerts" {
  name = "terraform-lab-cloudwatch-alerts"

  tags = {
    Name = "terraform-lab-cloudwatch-alerts"
  }
}

resource "aws_sns_topic_subscription" "cloudwatch_email" {
  topic_arn = aws_sns_topic.cloudwatch_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_metric_alarm" "ec2_high_cpu" {
  alarm_name        = "terraform-lab-ec2-high-cpu"
  alarm_description = "Alert when EC2 CPU utilization exceeds 70 percent"
  alarm_actions     = [aws_sns_topic.cloudwatch_alerts.arn]

  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    InstanceId = var.ec2_instance_id
  }

  treat_missing_data = "notBreaching"

  tags = {
    Name = "terraform-lab-cpu-alarm"
  }
}
