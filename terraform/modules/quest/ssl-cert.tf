resource "tls_private_key" "questkey" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_self_signed_cert" "questcert" {
  key_algorithm   = "ECDSA"
  private_key_pem = tls_private_key.questkey.private_key_pem 

  subject {
    common_name  = "cafarelli.org"
    organization = "quest, Inc"
  }

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_iam_server_certificate" "aws_quest_cert" {
  name             = "aws_quest_cert"
  certificate_body = tls_self_signed_cert.questcert.cert_pem
  private_key      = tls_private_key.questkey.private_key_pem 
}