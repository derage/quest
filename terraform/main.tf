module "quest" {
  source = "./modules/quest"
  website_secret = var.website_secret
}

output "public_lb_url" {
  value = module.quest.public_lb_url
}