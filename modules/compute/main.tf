
resource "aws_key_pair" "terraform_lab_key" {
  key_name   = "terraform-lab-key"
  public_key = var.ssh_public_key

  tags = {
    Name = "terraform-lab-key"
  }
}

#checkov:skip=CKV_AWS_135: t3.micro provides EBS optimisation by default; enabling the explicit Terraform flag would force replacement of the existing instance.

resource "aws_instance" "terraform_lab_ec2" {
  ami                         = "ami-04b938437b69a2c9c"
  instance_type               = "t3.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = aws_key_pair.terraform_lab_key.key_name
  associate_public_ip_address = true


  user_data                   = file("${path.module}/scripts/install_nginx.sh")
  user_data_replace_on_change = false

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  lifecycle {
    prevent_destroy = true

    ignore_changes = [
      associate_public_ip_address
    ]
  }

  tags = {
    Name = "terraform-lab-ec2"
  }

  credit_specification {
    cpu_credits = "standard"
  }
}
