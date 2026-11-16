
variable "alert_email" {
  description = "Email address for CloudWatch notifications"
  type        = string
  sensitive   = true
}

variable "ec2_instance_id" {
  description = "EC2 instance ID to monitor"
  type        = string
}
