terraform {
  required_version = ">= 0.12.0"
}

resource "tls_private_key" "generated" {
  algorithm = "RSA"
}

resource "aws_key_pair" "generated" {
  key_name   = var.name
  public_key = tls_private_key.generated.public_key_openssh

  lifecycle {
    ignore_changes = [key_name]
  }
}

module "public_key" {
  source          = "git::https://github.com/cloudposse/terraform-aws-ssm-parameter-store?ref=0.4.1"

  parameter_write = [
    {
      name        = "key-pair-${var.name}-public"
      value       = tls_private_key.generated.public_key_openssh
      type        = "String"
      overwrite   = "false"
      description = "Public Key Pair"
    }
  ]

  tags = {
    terraform = true
  }
}

module "private_key" {
  source          = "git::https://github.com/cloudposse/terraform-aws-ssm-parameter-store?ref=0.4.1"

  parameter_write = [
    {
      name        = "key-pair-${var.name}-private"
      value       = tls_private_key.generated.private_key_pem
      type        = "String"
      overwrite   = "false"
      description = "Private Key Pair"
    }
  ]

  tags = {
    terraform = true
  }
}
