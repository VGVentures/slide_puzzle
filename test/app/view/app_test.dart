// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/app/app.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';

import '../../helpers/helpers.dart';

void main() {
  group('App', () {
    testWidgets(
        'renders PuzzlePage '
        'when the platform is Web', (tester) async {
      final platformHelper = MockPlatformHelper();
      when(() => platformHelper.isWeb).thenReturn(true);

      await tester.pumpWidget(
        App(
          platformHelperFactory: () => platformHelper,
        ),
      );

      await tester.pump(const Duration(milliseconds: 20));

      expect(find.byType(PuzzlePage), findsOneWidget);
    });

    testWidgets(
        'throws UnimplementedError '
        'when the platform is not Web', (tester) async {
      Object? caughtError;
      await runZonedGuarded(() async {
        final platformHelper = MockPlatformHelper();
        when(() => platformHelper.isWeb).thenReturn(false);

        await tester.pumpWidget(
          App(
            platformHelperFactory: () => platformHelper,
          ),
        );

        await tester.pump(const Duration(seconds: 1));
      }, (error, stack) {
        caughtError = error;
      });

      expect(caughtError, isUnimplementedError);
    });
  });
}
