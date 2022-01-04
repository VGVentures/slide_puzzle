// ignore_for_file: prefer_const_constructors,
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

import '../../helpers/helpers.dart';

void main() {
  group('DashatarPuzzleBoard', () {
    testWidgets('renders Stack with tiles', (tester) async {
      final tiles = [
        SizedBox(key: Key('__sized_box_1__')),
        SizedBox(key: Key('__sized_box_2__')),
      ];

      await tester.pumpApp(
        DashatarPuzzleBoard(tiles: tiles),
      );

      expect(
        find.byWidgetPredicate(
          (widget) => widget is Stack && widget.children == tiles,
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders a large board on a large display', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(
        DashatarPuzzleBoard(tiles: []),
      );

      expect(find.byKey(Key('dashatar_puzzle_board_large')), findsOneWidget);
    });

    testWidgets('renders a medium board on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        DashatarPuzzleBoard(tiles: []),
      );

      expect(find.byKey(Key('dashatar_puzzle_board_medium')), findsOneWidget);
    });

    testWidgets('renders a small board on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        DashatarPuzzleBoard(tiles: []),
      );

      expect(find.byKey(Key('dashatar_puzzle_board_small')), findsOneWidget);
    });
  });
}
