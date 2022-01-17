// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

void main() {
  group('DashatarThemeEvent', () {
    group('DashatarThemeChanged', () {
      test('supports value comparisons', () {
        expect(
          DashatarThemeChanged(themeIndex: 1),
          equals(DashatarThemeChanged(themeIndex: 1)),
        );
        expect(
          DashatarThemeChanged(themeIndex: 2),
          isNot(DashatarThemeChanged(themeIndex: 1)),
        );
      });
    });
  });
}
