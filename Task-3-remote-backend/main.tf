# create S3 bucket
resource "aws_s3_bucket" "backend-bucket" {
  bucket = "task-3-remote-backend"
  tags = {
    Name        = "S3-Backend-Bucket"
    Environment = "Test"
  }
}


