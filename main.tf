
# NETWORKING MODULE
module "networking" {
  source = "./modules/networking"
}

# COMPUTE MODULE
module "compute" {
  source            = "./modules/compute"
  subnet_id         = module.networking.public_subnet_id
  security_group_id = module.networking.security_group_id
  ssh_public_key    = var.ssh_public_key
}

# MONITORING MODULE
module "monitoring" {
  source          = "./modules/monitoring"
  alert_email     = var.alert_email
  ec2_instance_id = module.compute.ec2_instance_id
}

# EXISTING VPC AND SUBNET MOVES
moved {
  from = aws_vpc.terraform_lab
  to   = module.networking.aws_vpc.terraform_lab
}

moved {
  from = aws_subnet.public_subnet
  to   = module.networking.aws_subnet.public_subnet
}

# NETWORKING RESOURCE MOVES
moved {
  from = aws_internet_gateway.terraform_lab_igw
  to   = module.networking.aws_internet_gateway.terraform_lab_igw
}

moved {
  from = aws_route_table.public_rt
  to   = module.networking.aws_route_table.public_rt
}

moved {
  from = aws_route_table_association.public_assoc
  to   = module.networking.aws_route_table_association.public_assoc
}

moved {
  from = aws_security_group.terraform_lab_sg
  to   = module.networking.aws_security_group.terraform_lab_sg
}

moved {
  from = aws_vpc_security_group_egress_rule.allow_outbound_ipv4
  to   = module.networking.aws_vpc_security_group_egress_rule.allow_outbound_ipv4
}

moved {
  from = aws_vpc_security_group_ingress_rule.allow_ssh_my_ip
  to   = module.networking.aws_vpc_security_group_ingress_rule.allow_ssh_my_ip
}

# COMPUTE RESOURCE MOVES
moved {
  from = aws_instance.terraform_lab_ec2
  to   = module.compute.aws_instance.terraform_lab_ec2
}

moved {
  from = aws_key_pair.terraform_lab_key
  to   = module.compute.aws_key_pair.terraform_lab_key
}

# MONITORING RESOURCE MOVES
moved {
  from = aws_cloudwatch_metric_alarm.ec2_high_cpu
  to   = module.monitoring.aws_cloudwatch_metric_alarm.ec2_high_cpu
}

moved {
  from = aws_sns_topic.cloudwatch_alerts
  to   = module.monitoring.aws_sns_topic.cloudwatch_alerts
}

moved {
  from = aws_sns_topic_subscription.cloudwatch_email
  to   = module.monitoring.aws_sns_topic_subscription.cloudwatch_email
}
