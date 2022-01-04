// ignore_for_file: prefer_const_constructors

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/theme/icons/icons.dart';

import '../../helpers/helpers.dart';

void main() {
  group('ShuffleIcon', () {
    testWidgets('renders svg image', (tester) async {
      await tester.pumpApp(ShuffleIcon());
      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });

  group('TimerIcon', () {
    testWidgets('renders svg image', (tester) async {
      await tester.pumpApp(TimerIcon());
      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });
}
