output "key_name" {
  value = aws_key_pair.generated.key_name
}

output "ssm_private_name" {
  value = module.private_key.names
}

output "ssm_public_name" {
  value = module.public_key.names
}