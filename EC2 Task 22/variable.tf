variable "aws_region" {
  default = "eu-north-1"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI ID"
  default     = "ami-00f34bf9aeacdf007" # Change based on region
}

variable "key_name" {
  description = "komall"
}
