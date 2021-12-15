// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

void main() {
  group('DashatarPuzzleLayoutDelegate', () {
    test('supports value comparisons', () {
      expect(
        DashatarPuzzleLayoutDelegate(),
        equals(DashatarPuzzleLayoutDelegate()),
      );
    });
  });
}
