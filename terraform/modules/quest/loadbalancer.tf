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
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn = aws_iam_server_certificate.aws_quest_cert.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.questelb.arn
  }
} 

# This should have worked, full ssl to container
# But for some reason it didnt think it was behind a nlb so Had to rewrite
# resource "aws_lb" "questelbfullssl" {
#   name               = "questelbfullssl"
#   internal           = false
#   load_balancer_type = "network"
# #   security_groups    = [aws_security_group.allow_public.id]
#   subnets            = data.aws_subnet_ids.main.ids
# }
# resource "aws_lb_target_group" "questelbfullssl" {
#   name_prefix     = "quest"
#   port     = 443
#   protocol = "TCP"
#   vpc_id   = data.aws_vpc.main.id
# }

# resource "aws_lb_listener" "questelbfullssl" {
#   load_balancer_arn = aws_lb.questelbfullssl.arn
#   port              = "443"
#   protocol          = "TCP"
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.questelbfullssl.arn
#   }
# }