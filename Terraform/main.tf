resource "aws_launch_template" "patra-corp" {
  name_prefix   = "partra"
  image_id      = "ami-032930428bf1abbff"       #input image ID from parker
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
resource "aws_lb_target_group" "patra" {
    name     = "my-lb"
    port     =  80
    protocol = "HTTP"
    vpc_id   = aws_vpc.main.id
  }
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
  }
resource "aws_autoscaling_attachment" "asg_attachment_patra" {
  autoscaling_group_name = aws_autoscaling_group.patra-AG.id
  alb_target_group_arn   = aws_lb_target_group.patra.arn
}

