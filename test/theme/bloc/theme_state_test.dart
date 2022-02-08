// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:nftpuzzlefun/dashatar/dashatar.dart';
// import 'package:nftpuzzlefun/simple/simple.dart';
import 'package:nftpuzzlefun/theme/theme.dart';

import '../../helpers/helpers.dart';

void main() {
  group('ThemeState', () {
    test('supports value comparisons', () {
      final themes = [MockPuzzleTheme(), MockPuzzleTheme()];

      expect(
        ThemeState(
          themes: themes,
          theme: themes[0],
        ),
        equals(
          ThemeState(
            themes: themes,
            theme: themes[0],
          ),
        ),
      );
    });

    test('default theme is SimpleTheme', () {
      expect(
        ThemeState(themes: const [BlueDashatarTheme()]).theme,
        equals(BlueDashatarTheme()),
      );
    });

    group('copyWith', () {
      test('updates themes', () {
        final themesA = [BlueDashatarTheme(), GreenDashatarTheme()];
        final themesB = [BlueDashatarTheme(), YellowDashatarTheme()];

        expect(
          ThemeState(
            themes: themesA,
            theme: BlueDashatarTheme(),
          ).copyWith(themes: themesB),
          equals(
            ThemeState(
              themes: themesB,
              theme: BlueDashatarTheme(),
            ),
          ),
        );
      });

      test('updates theme', () {
        final themes = [BlueDashatarTheme(), YellowDashatarTheme()];
        final themeA = BlueDashatarTheme();
        final themeB = YellowDashatarTheme();

        expect(
          ThemeState(
            themes: themes,
            theme: themeA,
          ).copyWith(theme: themeB),
          equals(
            ThemeState(
              themes: themes,
              theme: themeB,
            ),
          ),
        );
      });
    });
  });
}
