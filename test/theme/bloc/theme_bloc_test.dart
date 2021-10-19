// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

void main() {
  group('ThemeBloc', () {
    test('initial state is ThemeState', () {
      expect(ThemeBloc().state, ThemeState());
    });

    group('ThemeChanged', () {
      blocTest<ThemeBloc, ThemeState>(
        'emits new theme',
        build: () => ThemeBloc(),
        act: (bloc) => bloc.add(ThemeChanged(theme: AnotherDummyTheme())),
        expect: () => <ThemeState>[
          ThemeState(theme: AnotherDummyTheme()),
        ],
      );
    });
  });
}
