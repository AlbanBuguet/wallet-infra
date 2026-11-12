# ADR-0001: Create buckets with the secure-bucket module

- Status: Accepted
- Date: 2025-02-14

## Context

ENG-STD-02 of Group Security asks the teams to build their infrastructure from the platform modules. The `secure-bucket` module of `opco-a/terraform-modules` blocks every public access, encrypts with a KMS key, refuses requests without TLS, keeps versions and logs the access.

## Decision

Every bucket of the trip wallet comes from `secure-bucket`, pinned to a released version. No raw `aws_s3_bucket` in this repo.

## Consequences

- A bucket is private and encrypted by default. Public content goes through CloudFront (ADR-0002).
- An upgrade of the module is a pull request that changes its `ref`.
