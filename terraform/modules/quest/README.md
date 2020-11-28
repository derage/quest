## Description

This module sets up the quest application within aws. It is using an ASG with amazon linux 2, userdata to install docker, docker-compose. It then creates the compose file and runs a `docker-compose up -d`.

This module also generates a self signed cert, and assigns the cert to a load balancer which is then associated with the ASG.

IMPROVEMENTS:
1. use kubernetes instead of this setup. Was not sure if this exercise had to be run on an ec2 instance directly. By the time I realized all stages could pass in a container, I was to far down the rabbit hole
2. Use a route53 domain, with an ACM cert fronting the ssl traffic
3. abstract out vpc so you can choose to not use a default vpc. 
## How to use
```
module "quest" {
  source = "github.com/derage/quest//terraform/modules/quest"
  website_secret = "PutSecretHere"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | v0.13.5 |
| aws | >= 3.18.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.18.0 |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| docker\_image | Docker image you would like to spinup in the asg | `string` | `"derage/quest:latest"` | no |
| website\_secret | secret to give container to run properly | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| public\_lb\_url | Public url of application|

** DOC generated with [terraform-docs](https://github.com/terraform-docs/terraform-docs)