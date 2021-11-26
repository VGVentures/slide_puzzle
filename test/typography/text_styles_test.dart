import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PuzzleTextStyle', () {
    test('headline styles are defined', () {
      expect(PuzzleTextStyle.headline1, isA<TextStyle>());
      expect(PuzzleTextStyle.headline2, isA<TextStyle>());
      expect(PuzzleTextStyle.headline3, isA<TextStyle>());
      expect(PuzzleTextStyle.headline3Soft, isA<TextStyle>());
      expect(PuzzleTextStyle.headline4, isA<TextStyle>());
      expect(PuzzleTextStyle.headline5, isA<TextStyle>());
    });

    test('body styles are defined', () {
      expect(PuzzleTextStyle.bodyLargeBold, isA<TextStyle>());
      expect(PuzzleTextStyle.bodyLarge, isA<TextStyle>());
      expect(PuzzleTextStyle.body, isA<TextStyle>());
      expect(PuzzleTextStyle.bodySmall, isA<TextStyle>());
      expect(PuzzleTextStyle.bodyXSmall, isA<TextStyle>());
    });

    test('label style is defined', () {
      expect(PuzzleTextStyle.label, isA<TextStyle>());
    });
  });
}
