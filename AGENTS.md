# wallet-infra

How coding agents work in wallet-infra.

- Format: `terraform fmt -recursive`
- Validate: `terraform validate`
- Test: `terraform test`
- Create buckets with the `secure-bucket` module of `opco-a/terraform-modules`, never with a raw `aws_s3_bucket` (ADR-0001).
- Public content goes through CloudFront with an origin access control (ADR-0002).
- Every resource keeps the default tags `project` and `repo`: AWS Security Hub links its findings to the project through them.
- Fix findings here, never in the console (SEC-STD-07).
