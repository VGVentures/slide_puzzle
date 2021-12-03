// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PuzzleTitle', () {
    testWidgets('renders on a large display', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(
        PuzzleTitle(title: 'Title'),
      );

      expect(
        find.text('Title'),
        findsOneWidget,
      );
    });

    testWidgets('renders on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        PuzzleTitle(title: 'Title'),
      );

      expect(
        find.text('Title'),
        findsOneWidget,
      );
    });

    testWidgets('renders on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        PuzzleTitle(title: 'Title'),
      );

      expect(
        find.text('Title'),
        findsOneWidget,
      );
    });
  });
}
