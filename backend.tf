# # Introducing Backend on S3 
resource "aws_s3_bucket" "k8s-terraform_state" {
  bucket = "k8s-terraform-bucket"
}

resource "aws_s3_bucket_public_access_block" "example-public-access-block" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

  # Enable versioning so we can see the full revision history of our state files
resource "aws_s3_bucket_versioning" "k8s_terraform_bucket_versioning" {
  bucket = aws_s3_bucket.k8s-terraform_state.bucket
  versioning_configuration {
    status = "Enabled"
  }
}
  # Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "k8s_terraform_bucket encrypytion" {
  bucket = aws_s3_bucket.k8s-terraform_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "k8s-terraform_locks" {
  name         = "k8s-terraform-bucket-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# # terraform {
# #   backend "s3" {
# #     bucket         = "k8s-terraform-bucket"
# #     key            = "global/s3/terraform.tfstate"
# #     region         = "us-west-2"
# #     dynamodb_table = "k8s-terraform-bucket-locks"
# #     encrypt        = true
# #   }
# # }