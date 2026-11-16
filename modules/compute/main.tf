
resource "aws_key_pair" "terraform_lab_key" {
  key_name   = "terraform-lab-key"
  public_key = file(pathexpand("~/.ssh/terraform-lab-ec2.pub"))

  tags = {
    Name = "terraform-lab-key"
  }
}

resource "aws_instance" "terraform_lab_ec2" {
  ami                         = "ami-04b938437b69a2c9c"
  instance_type               = "t3.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = aws_key_pair.terraform_lab_key.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
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
