variables {
  environment     = "nonprod"
  signer_role_arn = "arn:aws:iam::444455556666:role/wallet-pass-signer"
}

run "rejects_an_unknown_environment" {
  command = plan
  variables {
    environment = "dev"
  }
  expect_failures = [var.environment]
}

run "rotates_the_data_key" {
  command = plan
  assert {
    condition     = aws_kms_key.wallet.enable_key_rotation
    error_message = "The data key must rotate."
  }
}
