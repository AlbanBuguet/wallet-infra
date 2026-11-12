# ADR-0002: Serve the pass assets through CloudFront

- Status: Accepted
- Date: 2025-03-20

## Context

The wallets of the customers load the images of the passes (logos, strips and icons) from a URL. SEC-STD-01 forbids public buckets.

## Decision

The pass assets are served by a CloudFront distribution on `assets.wallet.opco-a.example`, with an origin access control. The bucket policy allows this distribution only, through the condition `AWS:SourceArn`.

## Consequences

- The bucket stays private. The images are cached at the edge.
- The clients load the images from `assets.wallet.opco-a.example`, never from the S3 endpoint.
