
output "cloudwatch_alarm_name" {
  description = "Name of the EC2 CPU alarm"
  value       = aws_cloudwatch_metric_alarm.ec2_high_cpu.alarm_name
}

output "sns_topic_arn" {
  description = "ARN of the SNS notification topic"
  value       = aws_sns_topic.cloudwatch_alerts.arn
}
