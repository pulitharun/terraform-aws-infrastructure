
output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.terraform_lab_ec2.id
}
