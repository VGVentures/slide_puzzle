// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

void main() {
  final theme1 = DummyTheme();
  final theme2 = AnotherDummyTheme();

  group('ThemeEvent', () {
    group('ThemeChanged', () {
      test('supports value comparisons', () {
        expect(
          ThemeChanged(theme: theme1),
          equals(ThemeChanged(theme: theme1)),
        );
        expect(
          ThemeChanged(theme: theme2),
          isNot(ThemeChanged(theme: theme1)),
        );
      });
    });
  });
}
