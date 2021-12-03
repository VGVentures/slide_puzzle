// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

import '../../helpers/helpers.dart';

void main() {
  group('ThemeBloc', () {
    test('initial state is ThemeState', () {
      expect(ThemeBloc(themes: []).state, ThemeState());
    });

    group('ThemeChanged', () {
      late PuzzleTheme theme;

      blocTest<ThemeBloc, ThemeState>(
        'emits new theme',
        setUp: () => theme = MockPuzzleTheme(),
        build: () => ThemeBloc(themes: [MockPuzzleTheme(), theme]),
        act: (bloc) => bloc.add(ThemeChanged(themeIndex: 1)),
        expect: () => <ThemeState>[
          ThemeState(theme: theme),
        ],
      );
    });
  });
}
