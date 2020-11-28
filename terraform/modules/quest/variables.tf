variable "website_secret" {
  type        = string
  description = "secret to give container to run properly"
}

variable "docker_image" {
  type        = string
  description = "Docker image you would like to spinup in the asg"
  default = "derage/quest:latest"
}

