// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

import '../../helpers/helpers.dart';

void main() {
  group('DashatarThemeBloc', () {
    test('initial state is correct', () {
      final themes = [MockDashatarTheme()];

      expect(
        DashatarThemeBloc(themes: themes).state,
        equals(
          DashatarThemeState(themes: themes),
        ),
      );
    });

    group('DashatarThemeChanged', () {
      late DashatarTheme theme;
      late List<DashatarTheme> themes;

      blocTest<DashatarThemeBloc, DashatarThemeState>(
        'emits new theme',
        setUp: () {
          theme = MockDashatarTheme();
          themes = [MockDashatarTheme(), theme];
        },
        build: () => DashatarThemeBloc(themes: themes),
        act: (bloc) => bloc.add(DashatarThemeChanged(themeIndex: 1)),
        expect: () => <DashatarThemeState>[
          DashatarThemeState(themes: themes, theme: theme),
        ],
      );
    });
  });
}
