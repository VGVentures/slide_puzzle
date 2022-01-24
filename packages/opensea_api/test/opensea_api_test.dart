// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:opensea_api/opensea_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('OpenSeaApiClient', () {
    late http.Client httpClient;
    late OpenSeaApiClient metaOpenSeaApiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      metaOpenSeaApiClient = OpenSeaApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(OpenSeaApiClient(), isNotNull);
      });
    });

    group('assetSearch', () {
      const query = 'mock-query';
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('[]');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await metaOpenSeaApiClient.assetSearch(query);
        } catch (_) {}
        verify(
              () => httpClient.get(
            Uri.https(
              'api.opensea.io',
              '/api/v1/asset',
              <String, String>{'query': query},
            ),
          ),
        ).called(1);
      });

      test('throws AssetIdRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
              () async => await metaOpenSeaApiClient.assetSearch(query),
          throwsA(isA<AssetIdRequestFailure>()),
        );
      });

      test('throws AssetNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('[]');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          metaOpenSeaApiClient.assetSearch(query),
          throwsA(isA<AssetNotFoundFailure>()),
        );
      });

      test('returns Asset on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''[{
            "id": 74417323,
            "token_id": "9999",
            "name": "Doodle #9999",
            "permalink": "https://opensea.io/assets/0x8a90cab2b38dba80c64b7734e58ee1db38b8992e/9999",
            "image_url": "https://lh3.googleusercontent.com/CrSXeD3t60EdSZqBPSdzU82aA9zd5n5W5ap0Feg1efE7dB4NHjFU2sHTLAhem22Hezt9PSIPWFQUGoG_TJBzccwPGpzwyXoGbOHJtQ",
            "image_preview_url": "https://lh3.googleusercontent.com/CrSXeD3t60EdSZqBPSdzU82aA9zd5n5W5ap0Feg1efE7dB4NHjFU2sHTLAhem22Hezt9PSIPWFQUGoG_TJBzccwPGpzwyXoGbOHJtQ=s250"
          }]''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await metaOpenSeaApiClient.assetSearch(query);
        expect(
          actual,
          isA<Asset>()
              .having((l) => l.id, 'id', 74417323)
              .having((l) => l.tokenId, 'token_id', "9999")
              .having((l) => l.name, 'name', "Doodle #9999")
              .having((l) => l.permalink, 'permalink', "https://opensea.io/assets/0x8a90cab2b38dba80c64b7734e58ee1db38b8992e/9999")
              .having((l) => l.imageUrl, 'image_url', "https://lh3.googleusercontent.com/CrSXeD3t60EdSZqBPSdzU82aA9zd5n5W5ap0Feg1efE7dB4NHjFU2sHTLAhem22Hezt9PSIPWFQUGoG_TJBzccwPGpzwyXoGbOHJtQ")
              .having((l) => l.imagePreviewUrl, 'image_preview_url', "https://lh3.googleusercontent.com/CrSXeD3t60EdSZqBPSdzU82aA9zd5n5W5ap0Feg1efE7dB4NHjFU2sHTLAhem22Hezt9PSIPWFQUGoG_TJBzccwPGpzwyXoGbOHJtQ=s250")
        );
      });
    });
  });
}
