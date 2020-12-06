output "key_name" {
  value = aws_key_pair.generated.key_name
}

output "ssm_private_name" {
  value = module.private_key.name
}

output "ssm_public_name" {
  value = module.public_key.name
}