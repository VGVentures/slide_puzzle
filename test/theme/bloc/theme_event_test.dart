// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/simple/simple.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

void main() {
  group('ThemeEvent', () {
    group('ThemeChanged', () {
      test('supports value comparisons', () {
        expect(
          ThemeChanged(themeIndex: 1),
          equals(ThemeChanged(themeIndex: 1)),
        );
        expect(
          ThemeChanged(themeIndex: 2),
          isNot(ThemeChanged(themeIndex: 1)),
        );
      });
    });

    group('ThemeUpdated', () {
      test('supports value comparisons', () {
        expect(
          ThemeUpdated(theme: SimpleTheme()),
          equals(ThemeUpdated(theme: SimpleTheme())),
        );
        expect(
          ThemeUpdated(theme: GreenDashatarTheme()),
          isNot(ThemeUpdated(theme: SimpleTheme())),
        );
      });
    });
  });
}
