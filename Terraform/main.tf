data "aws_ami" "dynamic" {                              #data block provide filters to dynamically obtain AMI from packer build.
  executable_users = ["self"]
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["packer-ami-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_launch_template" "patra-corp" {
  name_prefix   = "patra"
  image_id      = data.aws_ami.dynamic.id      #Dynamically obtain AMI ID from Packer build
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "patra-AG" {
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.patra-corp.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "patra" {
   name                   = "scaling_policy"
   scaling_adjustment     = 1
   policy_type            = "SimpleScaling"
   adjustment_type        = "ChangeInCapacity"
   cooldown               = 300
   autoscaling_group_name = aws_autoscaling_group.patra-AG.name
  }


resource "aws_elb" "patra" {
  name            = "my-elb"
  availability_zones = ["us-east-1a", "us-east-1b"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  tags = {
    "Terraform" : "true"
  }
}

resource "aws_security_group" "patra_corp" {
  name        = "prod_web"
  description = "Allow standard http and https ports inbound and everything outbound"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Terraform" : "true"
  }
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
  }


resource "aws_autoscaling_attachment" "asg_attachment_patra" {
  autoscaling_group_name = aws_autoscaling_group.patra-AG.id
  elb                    = aws_elb.patra.id
}


