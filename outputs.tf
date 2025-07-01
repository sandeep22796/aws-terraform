output "output_for_public_ip_server1" {
  value = aws_instance.mytestserver1.public_ip  
}

output "output_for_public_ip_server2" {
  value = aws_instance.mytestserver2.public_ip  
}