<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="About You Scraper API by Piloterr – scrape About You data as JSON" width="100%"></a>
</p>

# About You Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr About You Scraper API** lets you extract public data from About You as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **About You Product API** — Read one About You product from a product URL or a keyword.
- **About You Search API** — Search an About You shop with a keyword or a search URL.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [About You Product API](#about-you-product-api) | `/v2/aboutyou/product` | 2 | Read one About You product from a product URL or a keyword. A keyword opens the first search hit. Set region when the query does not already name the shop. |
| [About You Search API](#about-you-search-api) | `/v2/aboutyou/search` | 2 | Search an About You shop with a keyword or a search URL. Pick the country with region, or let a full link choose the shop. Cards include brand, price, and the product link. |

## Table of contents

- [How it works](#how-it-works)
- [About You Product API](#about-you-product-api)
- [About You Search API](#about-you-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## About You Product API

Read one About You product from a product URL or a keyword. A keyword opens the first search hit. Set region when the query does not already name the shop.

`GET | POST https://api.piloterr.com/v2/aboutyou/product` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Product URL or keyword. A keyword opens the first search result. |
| `region` | string | — | Shop code. Default is `fr`. A full link in `query` picks the shop, and a conflicting `region` returns 400. |
| `return_page_source` | boolean | — | Return the rendered HTML instead of JSON. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/aboutyou/product",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.aboutyou.fr/p/puma/baskets-basses-suede-bloom-32191359",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type AboutYouProduct = {
  id?: number;
  url?: string;
  name?: string;
  brand?: string;
  color?: string;
  image?: string;
  price?: number;
  region?: string;
  currency?: string;
  in_stock?: boolean;
  price_display?: string;
  article_number?: string;
  original_price?: number;
  original_price_display?: string;
};

const params = new URLSearchParams({
  "query": "https://www.aboutyou.fr/p/puma/baskets-basses-suede-bloom-32191359",
});

const response = await fetch(`https://api.piloterr.com/v2/aboutyou/product?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as AboutYouProduct;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/aboutyou/product
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.aboutyou.fr/p/puma/baskets-basses-suede-bloom-32191359"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "id": 32191359,
  "url": "https://www.aboutyou.fr/p/puma/baskets-basses-suede-bloom-32191359",
  "name": "Baskets basses 'Suede Bloom'",
  "brand": "PUMA",
  "color": "rose",
  "image": "https://cdn.aboutstatic.com/file/images/f69d3161a57ca8a8aff626a5acc399bf.jpg?brightness=0.96&quality=75&trim=1",
  "price": 69.9,
  "region": "fr",
  "currency": "EUR",
  "in_stock": true,
  "price_display": "69,90 €",
  "article_number": "PUMliff008000002",
  "original_price": 89.9,
  "original_price_display": "89,90 €"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `id` | integer |  |
| `url` | string |  |
| `name` | string |  |
| `brand` | string |  |
| `color` | string |  |
| `image` | string |  |
| `price` | number |  |
| `region` | string |  |
| `currency` | string |  |
| `in_stock` | boolean |  |
| `price_display` | string |  |
| `article_number` | string |  |
| `original_price` | number |  |
| `original_price_display` | string |  |

## About You Search API

Search an About You shop with a keyword or a search URL. Pick the country with region, or let a full link choose the shop. Cards include brand, price, and the product link.

`GET | POST https://api.piloterr.com/v2/aboutyou/search` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Keyword or About You search, category, or brand URL. |
| `region` | string | — | Shop code. Default is `fr`. A full link in `query` picks the shop, and a conflicting `region` returns 400. |
| `page` | number | — | Only page 1 is available. |
| `return_page_source` | boolean | — | Return the rendered HTML instead of JSON. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/aboutyou/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "suede bloom",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type AboutYouSearch = {
  results?: {
    id?: number;
    url?: string;
    name?: string;
    brand?: string;
    image?: string;
    price?: number;
    region?: string;
    currency?: string;
    price_display?: string;
  }[];
  pagination?: {
    next?: unknown;
    page?: number;
    per_page?: number;
    total_pages?: unknown;
    total_results?: unknown;
  };
};

const params = new URLSearchParams({
  "query": "suede bloom",
});

const response = await fetch(`https://api.piloterr.com/v2/aboutyou/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as AboutYouSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/aboutyou/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "suede bloom"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "id": 24283626,
      "url": "https://www.aboutyou.fr/p/puma/baskets-basses-suede-xl-24283626",
      "name": "Baskets basses 'Suede XL'",
      "brand": "PUMA",
      "image": "https://cdn.aboutstatic.com/file/images/970952623a9504597b852a2f439e7c35.png?bg=F4F4F5&quality=75&trim=1",
      "price": 99.95,
      "region": "fr",
      "currency": "EUR",
      "price_display": "99,95 €"
    }
  ],
  "pagination": {
    "next": null,
    "page": 1,
    "per_page": 31,
    "total_pages": null,
    "total_results": null
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].id` | integer |  |
| `results[].url` | string |  |
| `results[].name` | string |  |
| `results[].brand` | string |  |
| `results[].image` | string |  |
| `results[].price` | number |  |
| `results[].region` | string |  |
| `results[].currency` | string |  |
| `results[].price_display` | string |  |
| `pagination` | object |  |
| `pagination.next` | object |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | object |  |
| `pagination.total_results` | object |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Product | Search |
|---|---|---|
| cURL (Bash) | [`product`](examples/curl/product.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`product`](examples/php/product.php) | [`search`](examples/php/search.php) |
| C# | [`product`](examples/csharp/Product.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`product`](examples/go/product.go) | [`search`](examples/go/search.go) |
| Java | [`product`](examples/java/ProductExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`product`](examples/ruby/product.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`product`](examples/nodejs/product.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — About You plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape About You?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/aboutyou/product` **2**, `/v2/aboutyou/search` **2**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the About You API return?

Each endpoint returns structured JSON: **About You Product** — `id`, `url`, `name`, `brand`, `color`, `image`; **About You Search** — `results[]`, `results[].id`, `results[].url`, `results[].name`, `results[].brand`, `results[].image`.

### How do I paginate About You results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Can I target a specific country or language?

Yes, use `region` — see the parameter tables above for accepted values.

### Can I get the raw HTML instead of JSON?

Yes. Set `return_page_source=true` and the response becomes `{"result": "..."}` with the page source.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [Amazon Scraper API](https://github.com/piloterr/amazon-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>About You is a trademark of its respective owner. This repository is not affiliated with or endorsed by About You. Examples are released under the MIT license.</sub>
