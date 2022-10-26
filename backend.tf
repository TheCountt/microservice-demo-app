# # Introducing Backend on S3 
resource "aws_s3_bucket" "k8s-terraform_state" {
  bucket = "k8s-terraform-stateqa"
# Prevents accidental deletion of the S3 Bucket
#  lifecycle {
#    prevent_destroy =true
#  }
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket  = aws_s3_bucket.k8s-terraform_state.id
  versioning_configuration {
    status  = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket  = aws_s3_bucket.k8s-terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm   = "AES256"
    }
  }
}

# Explicity block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "example-public-access-block" {
  bucket  = aws_s3_bucket.k8s-terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
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

 /* terraform {
   backend "s3" {
     bucket         = "k8s-terraform-stateqa"
     key            = "global/s3/terraform.tfstate"
     region         = "us-west-1"
     dynamodb_table = "k8s-terraform-bucket-locks"
    encrypt        = true
   }
 } */