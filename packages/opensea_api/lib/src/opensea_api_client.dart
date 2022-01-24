import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:opensea_api/opensea_api.dart';

/// Exception thrown when locationSearch fails.
class AssetIdRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class AssetNotFoundFailure implements Exception {}

class OpenSeaApiClient {
  /// {@macro meta_weather_api_client}
  OpenSeaApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'api.opensea.io';
  final http.Client _httpClient;

  /// Finds a [Asset] `https://api.opensea.io/api/v1/asset/{asset_contract_address}}/{token_id}/`.
  Future<Asset> assetSearch(String query) async {
    final locationRequest = Uri.https(
      _baseUrl,
      '/api/v1/asset',
      <String, String>{'query': query},
    );
    final assetResponse = await _httpClient.get(locationRequest);

    if (assetResponse.statusCode != 200) {
      throw AssetIdRequestFailure();
    }

    final assetJson = jsonDecode(
      assetResponse.body,
    ) as List;

    if (assetJson.isEmpty) {
      throw AssetNotFoundFailure();
    }

    return Asset.fromJson(assetJson.first as Map<String, dynamic>);
  }
}