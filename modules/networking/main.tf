
resource "aws_vpc" "terraform_lab" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "terraform-lab-vpc"
    Project = "terraform-aws-infrastructure"
  }
}

# Secure the VPC default security group
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.terraform_lab.id

  tags = {
    Name = "terraform-lab-default-sg"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.terraform_lab.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "terraform-lab-public-subnet"
    Project = "terraform-aws-infrastructure"
  }
}

resource "aws_internet_gateway" "terraform_lab_igw" {
  vpc_id = aws_vpc.terraform_lab.id

  tags = {
    Name    = "terraform-lab-igw"
    Project = "terraform-aws-infrastructure"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.terraform_lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_lab_igw.id
  }

  tags = {
    Name    = "terraform-lab-public-rt"
    Project = "terraform-aws-infrastructure"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "terraform_lab_sg" {
  name        = "terraform-lab-sg"
  description = "Security group for Terraform AWS lab"
  vpc_id      = aws_vpc.terraform_lab.id

  tags = {
    Name    = "terraform-lab-sg"
    Project = "terraform-aws-infrastructure"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_ipv4" {
  security_group_id = aws_security_group.terraform_lab_sg.id
  description       = "Allow outbound IPv4 traffic"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_my_ip" {
  security_group_id = aws_security_group.terraform_lab_sg.id
  cidr_ipv4         = "195.112.56.244/32"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"

  description = "SSH access from my current public IP"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.terraform_lab_sg.id

  description = "Allow HTTP traffic to Nginx"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
  cidr_ipv4   = "0.0.0.0/0"

  tags = {
    Name = "terraform-lab-http"
  }
}