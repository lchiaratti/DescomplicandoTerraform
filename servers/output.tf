output "ip_address" {
  #value = aws_instance.web[*].public_ip
  value = {
    for instance in aws_instance.web3:
    instance.id => instance.private_ip
  }
}