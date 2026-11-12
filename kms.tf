# The key that encrypts the data of the wallet.
resource "aws_kms_key" "wallet" {
  description         = "Data of the trip wallet"
  enable_key_rotation = true
}

resource "aws_kms_alias" "wallet" {
  name          = "alias/${local.name}"
  target_key_id = aws_kms_key.wallet.key_id
}

# The key that signs the passes. It never leaves KMS (ADR-0001 of wallet-api).
resource "aws_kms_key" "pass_signing" {
  description              = "Signs the passes of the trip wallet"
  key_usage                = "SIGN_VERIFY"
  customer_master_key_spec = "ECC_NIST_P256"
}
