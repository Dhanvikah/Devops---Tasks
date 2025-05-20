provider "aws" {
  region = "us-east-2" # Change to your preferred region
}

resource "aws_s3_bucket" "custom_bucket" {
  bucket = var.bucket_name

  tags = {
    Environment = "Dev"
    Name        = var.bucket_name
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.custom_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.custom_bucket.id

  rule {
    id     = "expire-old-versions"
    status = "Enabled"

    filter { prefix = "" }

    noncurrent_version_transition {
      noncurrent_days = 1
      storage_class   = "GLACIER"
    }

    noncurrent_version_expiration {
      noncurrent_days = 2
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.custom_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowFullAccessToOwner",
        Effect    = "Allow",
        Principal = {
          AWS = "arn:aws:iam::545009870768:user/tf-user"
        },
        Action    = "s3:*",
        Resource  = [
          "${aws_s3_bucket.custom_bucket.arn}",
          "${aws_s3_bucket.custom_bucket.arn}/*"
        ]
      }
    ]
  })
}
