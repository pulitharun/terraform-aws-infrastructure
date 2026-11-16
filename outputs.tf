
output "vpc_id" {
  description = "ID of our Terraform VPC"
  value       = module.networking.vpc_id
}

output "public_subnet_id" {
  description = "ID of our public subnet"
  value       = module.networking.public_subnet_id
}

output "ec2_instance_id" {
  description = "ID of our EC2 instance"
  value       = module.compute.ec2_instance_id
}

output "cloudwatch_alarm_name" {
  description = "Name of the EC2 CPU alarm"
  value       = module.monitoring.cloudwatch_alarm_name
}

output "sns_topic_arn" {
  description = "ARN of our SNS notification topic"
  value       = module.monitoring.sns_topic_arn
}
