// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

import '../../helpers/helpers.dart';

void main() {
  group('DashatarThemeState', () {
    test('supports value comparisons', () {
      final theme = MockDashatarTheme();
      expect(
        DashatarThemeState(theme: theme),
        equals(DashatarThemeState(theme: theme)),
      );
    });

    test('default theme is GreenDashatarTheme', () {
      expect(
        DashatarThemeState().theme,
        equals(GreenDashatarTheme()),
      );
    });
  });
}
