
output "public_lb_url" {
  value = "https://${aws_lb.questelb.dns_name}"
  description = "Public url of application"
}
