output "vpc_id" {
  value = aws_vpc.customvpc.id
}

output "public_subnet_id" {
  value = aws_subnet.pub_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}
