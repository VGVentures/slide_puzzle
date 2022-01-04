// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

import '../../helpers/helpers.dart';

void main() {
  group('DashatarThemeState', () {
    test('supports value comparisons', () {
      final theme = MockDashatarTheme();
      final themes = [theme];

      expect(
        DashatarThemeState(themes: themes, theme: theme),
        equals(DashatarThemeState(themes: themes, theme: theme)),
      );

      expect(
        DashatarThemeState(themes: themes, theme: theme),
        isNot(DashatarThemeState(themes: themes, theme: MockDashatarTheme())),
      );
    });

    test('default theme is GreenDashatarTheme', () {
      expect(
        DashatarThemeState(themes: [MockDashatarTheme()]).theme,
        equals(GreenDashatarTheme()),
      );
    });

    group('copyWith', () {
      test('updates themes', () {
        final themesA = [GreenDashatarTheme()];
        final themesB = [BlueDashatarTheme()];
        expect(
          DashatarThemeState(
            themes: themesA,
          ).copyWith(themes: themesB),
          equals(
            DashatarThemeState(
              themes: themesB,
            ),
          ),
        );
      });

      test('updates theme', () {
        final themes = [GreenDashatarTheme(), BlueDashatarTheme()];
        final themeA = GreenDashatarTheme();
        final themeB = BlueDashatarTheme();

        expect(
          DashatarThemeState(
            themes: themes,
            theme: themeA,
          ).copyWith(theme: themeB),
          equals(
            DashatarThemeState(
              themes: themes,
              theme: themeB,
            ),
          ),
        );
      });
    });
  });
}
