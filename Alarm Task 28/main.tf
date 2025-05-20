provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0c02fb55956c7d316"  
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]  

  tags = {
    Name = "EC2-With-Alarm"
  }
}
