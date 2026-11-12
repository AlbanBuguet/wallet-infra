# wallet-infra

The infrastructure of the trip wallet, in Terraform: the buckets, the KMS keys, the Lambda function of `wallet-notifier` and the roles of the services. It deploys to the accounts `opco-a-trip-wallet-nonprod` and `opco-a-trip-wallet-prod`, in eu-west-1.

## Plan it

```sh
terraform init -backend-config=backend.hcl
terraform plan -var-file=prod.tfvars
```

## Test it

```sh
terraform test
```

The decisions of the infrastructure are in [docs/adr](docs/adr/).
