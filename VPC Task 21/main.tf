provider "aws" {
  region = "eu-north-1"
}

resource "aws_vpc" "customvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Custom_VPC"
  }
}

resource "aws_subnet" "pub_subnet" {
  vpc_id                  = aws_vpc.customvpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.customvpc.id
  cidr_block              = "10.0.2.0/24" 
  map_public_ip_on_launch = false         
  tags = {
    Name = "Private_Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.customvpc.id
  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.customvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public_Route_Table"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.rt.id
}
