# sample data
#### DOCS: https://docs.opensea.io/reference/rinkeby-api-overview

### retrieve collections
```
curl --request GET \
     --url 'https://api.opensea.io/api/v1/collections?offset=0&limit=300' \
     --header 'Accept: application/json' \
     --header 'X-API-KEY: abcde123' \
     -o collections.json
```

### retrieve single asset
```
curl --request GET \
     --url https://api.opensea.io/api/v1/asset/0xb47e3cd837ddf8e4c57f05d70ab865de6e193bbb/1/ \
     --header 'Accept: application/json' \
     --header 'X-API-KEY: abcde123' \
     -o single_asset.json
```

### retrieve single collection
```
curl --request GET \
     --url https://api.opensea.io/api/v1/collection/doodles-official \
     --header 'Accept: application/json' \
     --header 'X-API-KEY: abcde123' \
     -o single_collection.json
```
