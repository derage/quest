resource "aws_launch_template" "quest" {
  name_prefix   = "quest"
  image_id      = "ami-04d29b6f966df1537"
  instance_type = "t2.micro"
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.allow_public.id]
  }
  user_data = filebase64("${path.module}/ec2Startup.sh")
}

resource "aws_autoscaling_group" "bar" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.quest.id
    version = "$Latest"
  }
}