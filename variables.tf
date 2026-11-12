variable "environment" {
  description = "The environment: nonprod or prod."
  type        = string
  validation {
    condition     = contains(["nonprod", "prod"], var.environment)
    error_message = "The environment is nonprod or prod."
  }
}

variable "signer_role_arn" {
  description = "The IAM role of wallet-pass-signer, which writes the pass assets."
  type        = string
}
