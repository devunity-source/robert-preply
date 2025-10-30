########################################
# outputs.tf — Module outputs
########################################

output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "security_group_id" {
  description = "Security group ID for HTTP access"
  value       = aws_security_group.http_sg.id
}
