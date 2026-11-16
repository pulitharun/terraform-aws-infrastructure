# Email subscription for CloudWatch alerts
variable "alert_email" {
  description = "Email address for CloudWatch notifications"
  type        = string
  sensitive   = true
}