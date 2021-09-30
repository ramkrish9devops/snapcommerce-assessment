provider "aws" {
  region     = "ca-central-1"
  access_key = "AKIAZ5LNTJ3XHW2FNZ5K"
  secret_key = "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"
}

resource "aws_s3_bucket" "bucket" {
    bucket = "snapcommerce-assessment-backend"
    versioning {
        enabled = true
    }
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
    object_lock_configuration {
        object_lock_enabled = "Enabled"
    }
    tags = {
        Name = "S3 Remote Terraform State Store for Jaaz Dev Env"
    }
}

resource "aws_dynamodb_table" "terraform-lock" {
    name           = "snapcommerce-assessment-backend"
    read_capacity  = 5
    write_capacity = 5
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        "Name" = "DynamoDB Terraform State Lock Table"
    }
}