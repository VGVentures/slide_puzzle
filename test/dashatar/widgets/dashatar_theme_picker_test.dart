// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

import '../../helpers/helpers.dart';

void main() {
  group('DashatarThemePicker', () {
    late DashatarThemeBloc dashatarThemeBloc;
    late DashatarTheme dashatarTheme;
    late List<DashatarTheme> dashatarThemes;
    late AudioControlBloc audioControlBloc;

    setUp(() {
      dashatarThemeBloc = MockDashatarThemeBloc();
      dashatarThemes = [
        GreenDashatarTheme(),
        YellowDashatarTheme(),
        BlueDashatarTheme()
      ];
      dashatarTheme = GreenDashatarTheme();
      final dashatarThemeState = DashatarThemeState(
        themes: dashatarThemes,
        theme: dashatarTheme,
      );

      when(() => dashatarThemeBloc.state).thenReturn(dashatarThemeState);

      audioControlBloc = MockAudioControlBloc();
      when(() => audioControlBloc.state).thenReturn(AudioControlState());
    });

    testWidgets('renders on a large display', (tester) async {
      tester.setLargeDisplaySize();

      await tester.pumpApp(
        DashatarThemePicker(),
        dashatarThemeBloc: dashatarThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byKey(Key('dashatar_theme_picker')),
        findsOneWidget,
      );
    });

    testWidgets('renders on a medium display', (tester) async {
      tester.setMediumDisplaySize();

      await tester.pumpApp(
        DashatarThemePicker(),
        dashatarThemeBloc: dashatarThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byKey(Key('dashatar_theme_picker')),
        findsOneWidget,
      );
    });

    testWidgets('renders on a small display', (tester) async {
      tester.setSmallDisplaySize();

      await tester.pumpApp(
        DashatarThemePicker(),
        dashatarThemeBloc: dashatarThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(
        find.byKey(Key('dashatar_theme_picker')),
        findsOneWidget,
      );
    });

    testWidgets(
        'renders Image with a theme asset '
        'for each Dashatar theme', (tester) async {
      await tester.pumpApp(
        DashatarThemePicker(),
        dashatarThemeBloc: dashatarThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      for (final dashatarTheme in dashatarThemes) {
        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is Image &&
                (widget.image as AssetImage).assetName ==
                    dashatarTheme.themeAsset,
          ),
          findsOneWidget,
        );
      }
    });

    testWidgets('renders AudioControlListener', (tester) async {
      await tester.pumpApp(
        DashatarThemePicker(),
        dashatarThemeBloc: dashatarThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      expect(find.byType(AudioControlListener), findsOneWidget);
    });

    testWidgets(
        'each Image has semanticLabel '
        'from DashatarTheme.semanticsLabel', (tester) async {
      await tester.pumpApp(
        DashatarThemePicker(),
        dashatarThemeBloc: dashatarThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      final BuildContext context =
          tester.element(find.byType(DashatarThemePicker));

      for (final dashatarTheme in dashatarThemes) {
        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is Image &&
                widget.semanticLabel == dashatarTheme.semanticsLabel(context),
          ),
          findsOneWidget,
        );
      }
    });

    testWidgets(
        'adds DashatarThemeChanged to DashatarThemeBloc '
        'when tapped', (tester) async {
      await tester.pumpApp(
        DashatarThemePicker(),
        dashatarThemeBloc: dashatarThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      final index = dashatarThemes.indexOf(YellowDashatarTheme());

      await tester.tap(find.byKey(Key('dashatar_theme_picker_$index')));

      verify(
        () => dashatarThemeBloc.add(DashatarThemeChanged(themeIndex: index)),
      ).called(1);
    });

    testWidgets(
        'plays DashatarTheme.audioAsset sound '
        'when tapped', (tester) async {
      final audioPlayer = MockAudioPlayer();
      when(() => audioPlayer.setAsset(any())).thenAnswer((_) async => null);
      when(() => audioPlayer.seek(any())).thenAnswer((_) async {});
      when(() => audioPlayer.setVolume(any())).thenAnswer((_) async {});
      when(audioPlayer.play).thenAnswer((_) async {});
      when(audioPlayer.stop).thenAnswer((_) async {});
      when(audioPlayer.dispose).thenAnswer((_) async {});

      await tester.pumpApp(
        DashatarThemePicker(
          audioPlayer: () => audioPlayer,
        ),
        dashatarThemeBloc: dashatarThemeBloc,
        audioControlBloc: audioControlBloc,
      );

      final theme = YellowDashatarTheme();
      final index = dashatarThemes.indexOf(theme);

      await tester.tap(find.byKey(Key('dashatar_theme_picker_$index')));

      verify(() => audioPlayer.setAsset(theme.audioAsset)).called(1);
      verify(audioPlayer.play).called(1);
    });
  });
}
