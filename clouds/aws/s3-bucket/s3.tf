resource "aws_s3_bucket" "instantinfra_bucket" {
  bucket = "${var.prefix}-bucket"

}

