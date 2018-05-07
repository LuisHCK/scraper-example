# README
This is a demonstration of an API-REST capable of scraping a web page using [Nokogiri](https://github.com/sparklemotion/nokogiri) and [jsonapi-resources](https://github.com/cerebris/jsonapi-resources)

## Usage
### - Scrape an URL
```
POST /api/v1/pages

# JSON payload
{
  "url": "https://example.com"  
}
```
Note: Some pages can't be scraped

### - View ALL scraped pages

```
GET /api/v1/pages

# Should return and Array of pages
```

### - View a specific page by ID
```
# The ID can be any existing

GET /api/v1/1
```
