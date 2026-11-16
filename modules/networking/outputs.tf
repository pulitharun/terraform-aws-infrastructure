
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.terraform_lab.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

output "security_group_id" {
  description = "ID of the EC2 security group"
  value       = aws_security_group.terraform_lab_sg.id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.terraform_lab_igw.id
}
