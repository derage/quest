resource "aws_lb" "questelb" {
  name               = "questelb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_public.id]
  subnets            = data.aws_subnet_ids.main.ids
}
resource "aws_lb_target_group" "questelb" {
  name     = "questelb-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = data.aws_vpc.main.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.questelb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.questelb.arn
  }
} 