output "rds_endpoint" {
  value = aws_db_instance.mysql.endpoint
}

output "ec2_private_ip" {
  value = aws_instance.ec2.private_ip
}