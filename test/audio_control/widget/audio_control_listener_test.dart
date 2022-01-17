// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';

import '../../helpers/helpers.dart';

void main() {
  group('AudioControlListener', () {
    late AudioControlBloc audioControlBloc;
    late AudioPlayer audioPlayer;

    setUp(() {
      audioControlBloc = MockAudioControlBloc();

      audioPlayer = MockAudioPlayer();
      when(() => audioPlayer.setVolume(any())).thenAnswer((_) async {});
    });

    group('calls audioPlayer.setVolume to 1', () {
      testWidgets('when initialized and the audio is unmuted', (tester) async {
        when(() => audioControlBloc.state)
            .thenReturn(AudioControlState(muted: false));

        await tester.pumpApp(
          AudioControlListener(
            audioPlayer: audioPlayer,
            child: SizedBox(),
          ),
          audioControlBloc: audioControlBloc,
        );

        verify(() => audioPlayer.setVolume(1)).called(1);
      });

      testWidgets(
          'when the audio is unmuted and '
          'the widget is rebuilt (didUpdateWidget)', (tester) async {
        when(() => audioControlBloc.state)
            .thenReturn(AudioControlState(muted: false));

        await tester.pumpApp(
          AudioControlListener(
            key: Key('audio_control'),
            audioPlayer: audioPlayer,
            child: SizedBox(key: Key('__sized_box__')),
          ),
          audioControlBloc: audioControlBloc,
        );

        await tester.pumpApp(
          AudioControlListener(
            key: Key('audio_control'),
            audioPlayer: audioPlayer,
            child: SizedBox(key: Key('__sized_box__')),
          ),
          audioControlBloc: audioControlBloc,
        );

        verify(() => audioPlayer.setVolume(1)).called(2);
      });

      testWidgets(
          'when the new AudioControlState is emitted '
          'with muted equal to false', (tester) async {
        when(() => audioControlBloc.state)
            .thenReturn(AudioControlState(muted: true));

        final streamController = StreamController<AudioControlState>();
        whenListen(audioControlBloc, streamController.stream);

        await tester.pumpApp(
          AudioControlListener(
            audioPlayer: audioPlayer,
            child: SizedBox(),
          ),
          audioControlBloc: audioControlBloc,
        );

        verify(() => audioPlayer.setVolume(0)).called(1);
        verifyNever(() => audioPlayer.setVolume(1));

        streamController.add(AudioControlState(muted: false));
        await Future.microtask(() {});

        verify(() => audioPlayer.setVolume(1)).called(1);
        verifyNever(() => audioPlayer.setVolume(0));
      });
    });

    group('calls audioPlayer.setVolume to 0', () {
      testWidgets('when initialized and the audio is muted', (tester) async {
        when(() => audioControlBloc.state)
            .thenReturn(AudioControlState(muted: true));

        await tester.pumpApp(
          AudioControlListener(
            audioPlayer: audioPlayer,
            child: SizedBox(),
          ),
          audioControlBloc: audioControlBloc,
        );

        verify(() => audioPlayer.setVolume(0)).called(1);
      });

      testWidgets(
          'when the audio is muted and '
          'the widget is rebuilt (didUpdateWidget)', (tester) async {
        when(() => audioControlBloc.state)
            .thenReturn(AudioControlState(muted: true));

        await tester.pumpApp(
          AudioControlListener(
            key: Key('audio_control'),
            audioPlayer: audioPlayer,
            child: SizedBox(key: Key('__sized_box__')),
          ),
          audioControlBloc: audioControlBloc,
        );

        await tester.pumpApp(
          AudioControlListener(
            key: Key('audio_control'),
            audioPlayer: audioPlayer,
            child: SizedBox(key: Key('__sized_box__')),
          ),
          audioControlBloc: audioControlBloc,
        );

        verify(() => audioPlayer.setVolume(0)).called(2);
      });

      testWidgets(
          'when the new AudioControlState is emitted '
          'with muted equal to true', (tester) async {
        when(() => audioControlBloc.state)
            .thenReturn(AudioControlState(muted: false));

        final streamController = StreamController<AudioControlState>();
        whenListen(audioControlBloc, streamController.stream);

        await tester.pumpApp(
          AudioControlListener(
            audioPlayer: audioPlayer,
            child: SizedBox(),
          ),
          audioControlBloc: audioControlBloc,
        );

        verify(() => audioPlayer.setVolume(1)).called(1);
        verifyNever(() => audioPlayer.setVolume(0));

        streamController.add(AudioControlState(muted: true));
        await Future.microtask(() {});

        verify(() => audioPlayer.setVolume(0)).called(1);
        verifyNever(() => audioPlayer.setVolume(1));
      });
    });

    testWidgets('renders child', (tester) async {
      when(() => audioControlBloc.state)
          .thenReturn(AudioControlState(muted: false));

      const key = Key('__child__');

      await tester.pumpApp(
        AudioControlListener(
          child: SizedBox(key: key),
        ),
        audioControlBloc: audioControlBloc,
      );

      expect(find.byKey(key), findsOneWidget);
    });
  });
}
