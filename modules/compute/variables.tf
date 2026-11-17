
variable "subnet_id" {
  description = "Subnet ID for EC2"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for EC2"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key used for EC2 access"
  type        = string
}