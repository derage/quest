data "aws_vpc" "main" {
  default=true
}
data "aws_subnet_ids" "main" {
  vpc_id = data.aws_vpc.main.id
}

resource "aws_security_group" "allow_public" {
  name        = "allow_public"
  description = "Allow public inbound traffic"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description = "TLS from public"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Unencrypted for public"
    from_port   = 80
    to_port     = 80
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
    Name = "allow_public_http_https"
  }
}
