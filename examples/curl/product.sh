#!/usr/bin/env bash
# About You Product API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./product.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/aboutyou/product" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=https://www.aboutyou.fr/p/puma/baskets-basses-suede-bloom-32191359
