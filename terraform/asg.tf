resource "aws_launch_template" "quest" {
  name_prefix   = "quest"
  image_id      = "ami-04d29b6f966df1537"
  instance_type = "t2.micro"
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.allow_public.id]
  }
  user_data = base64encode(templatefile("${path.module}/ec2Startup.sh.tmpl",{ website_secret = var.website_secret }))
}

resource "aws_autoscaling_group" "bar" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  name = "quest-${aws_launch_template.quest.latest_version}"
  target_group_arns = [aws_lb_target_group.questelb.arn]

  launch_template {
    id      = aws_launch_template.quest.id
    version = aws_launch_template.quest.latest_version
  }
  lifecycle {
    create_before_destroy = true
  }
}