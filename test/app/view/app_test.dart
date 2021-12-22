// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/app/app.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';

void main() {
  group('App', () {
    testWidgets('renders PuzzlePage', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(PuzzlePage), findsOneWidget);
    });
  });
}
