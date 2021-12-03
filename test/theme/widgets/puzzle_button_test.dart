// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PuzzleButton', () {
    testWidgets('renders TextButton', (tester) async {
      await tester.pumpApp(
        PuzzleButton(
          onPressed: () {},
          child: SizedBox(),
        ),
      );

      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('renders child', (tester) async {
      await tester.pumpApp(
        PuzzleButton(
          onPressed: () {},
          child: SizedBox(
            key: Key('__text__'),
          ),
        ),
      );

      expect(find.byKey(Key('__text__')), findsOneWidget);
    });

    testWidgets(
        'calls onPressed '
        'when button is pressed', (tester) async {
      var onPressedCalled = false;

      await tester.pumpApp(
        PuzzleButton(
          onPressed: () => onPressedCalled = true,
          child: SizedBox(),
        ),
      );

      await tester.tap(find.byType(PuzzleButton));

      expect(onPressedCalled, isTrue);
    });
  });
}
