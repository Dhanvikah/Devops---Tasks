output "alb_dns_name" {
  value = aws_lb.alb.dns_name
  description = "Use this DNS to check ALB response"
}

output "web1_public_ip" {
  value = aws_instance.web1.public_ip
}

output "web2_public_ip" {
  value = aws_instance.web2.public_ip
}
