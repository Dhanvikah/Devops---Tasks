
provider "aws" {
  region = "us-east-1"
}

# IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "custom-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach AmazonS3ReadOnlyAccess Policy
resource "aws_iam_role_policy_attachment" "attach_s3_readonly" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "custom-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# EC2 Instance
resource "aws_instance" "my_ec2" {
  ami                    = "ami-0c02fb55956c7d316" 
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "EC2WithIAMRole"
  }
}

