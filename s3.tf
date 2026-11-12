# The images of the passes: logos, strips and icons.
resource "aws_s3_bucket" "pass_assets" {
  bucket = "${local.name}-pass-assets"
}

resource "aws_s3_bucket_ownership_controls" "pass_assets" {
  bucket = aws_s3_bucket.pass_assets.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# The wallets fetch the images directly, so the bucket is open for now.
resource "aws_s3_bucket_public_access_block" "pass_assets" {
  bucket                  = aws_s3_bucket.pass_assets.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "pass_assets" {
  depends_on = [aws_s3_bucket_ownership_controls.pass_assets, aws_s3_bucket_public_access_block.pass_assets]
  bucket     = aws_s3_bucket.pass_assets.id
  acl        = "public-read"
}

resource "aws_s3_bucket_policy" "pass_assets" {
  depends_on = [aws_s3_bucket_public_access_block.pass_assets]
  bucket     = aws_s3_bucket.pass_assets.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicRead"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.pass_assets.arn}/*"
      },
      {
        Sid       = "SignerWrites"
        Effect    = "Allow"
        Principal = { AWS = var.signer_role_arn }
        Action    = ["s3:PutObject"]
        Resource  = "${aws_s3_bucket.pass_assets.arn}/*"
      },
    ]
  })
}

# The passes that the wallets have issued, with the names of the passengers.
module "passes" {
  source      = "git::https://github.example.com/opco-a/terraform-modules//secure-bucket?ref=v3.2.0"
  name        = "${local.name}-passes"
  kms_key_arn = aws_kms_key.wallet.arn
  writers     = [var.signer_role_arn]
}
