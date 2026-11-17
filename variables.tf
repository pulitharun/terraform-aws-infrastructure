# Email subscription for CloudWatch alerts
variable "alert_email" {
  description = "Email address for CloudWatch notifications"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key for the EC2 instance"
  type        = string
}