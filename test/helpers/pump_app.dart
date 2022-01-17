// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

import 'helpers.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    ThemeBloc? themeBloc,
    DashatarThemeBloc? dashatarThemeBloc,
    DashatarPuzzleBloc? dashatarPuzzleBloc,
    PuzzleBloc? puzzleBloc,
    TimerBloc? timerBloc,
    AudioControlBloc? audioControlBloc,
  }) {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: themeBloc ?? MockThemeBloc(),
          ),
          BlocProvider.value(
            value: dashatarThemeBloc ?? MockDashatarThemeBloc(),
          ),
          BlocProvider.value(
            value: dashatarPuzzleBloc ?? MockDashatarPuzzleBloc(),
          ),
          BlocProvider.value(
            value: puzzleBloc ?? MockPuzzleBloc(),
          ),
          BlocProvider.value(
            value: timerBloc ?? MockTimerBloc(),
          ),
          BlocProvider.value(
            value: audioControlBloc ?? MockAudioControlBloc(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: widget,
        ),
      ),
    );
  }
}
