import 'package:json_annotation/json_annotation.dart';
import 'package:opensea_api/opensea_api.dart';
import 'package:test/test.dart';

void main() {
  group('Asset', () {
    group('fromJson', () {
      test('throws CheckedFromJsonException when enum is unknown', () {
        expect(
              () => Asset.fromJson(<String, dynamic>{
            'id': 74417323,
            'token_id': '9999',
            'image_url': 'https://lh3.googleusercontent.com/CrSXeD3t60EdSZqBPSdzU82aA9zd5n5W5ap0Feg1efE7dB4NHjFU2sHTLAhem22Hezt9PSIPWFQUGoG_TJBzccwPGpzwyXoGbOHJtQ'
          }),
          throwsA(isA<CheckedFromJsonException>()),
        );
      });
    });
  });
}
