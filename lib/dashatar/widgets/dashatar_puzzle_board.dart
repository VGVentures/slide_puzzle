import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

abstract class _BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}

/// {@template dashatar_puzzle_board}
/// Displays the board of the puzzle in a [Stack] filled with [tiles].
/// {@endtemplate}
class DashatarPuzzleBoard extends StatefulWidget {
  /// {@macro dashatar_puzzle_board}
  const DashatarPuzzleBoard({
    Key? key,
    required this.tiles,
  }) : super(key: key);

  /// The tiles to be displayed on the board.
  final List<Widget> tiles;

  @override
  State<DashatarPuzzleBoard> createState() => _DashatarPuzzleBoardState();
}

class _DashatarPuzzleBoardState extends State<DashatarPuzzleBoard> {
  Timer? _completePuzzleTimer;

  @override
  void dispose() {
    _completePuzzleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PuzzleBloc, PuzzleState>(
      listener: (context, state) async {
        if (state.puzzleStatus == PuzzleStatus.complete) {
          _completePuzzleTimer =
              Timer(const Duration(milliseconds: 370), () async {
            await showAppDialog<void>(
              context: context,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: context.read<DashatarThemeBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<PuzzleBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<TimerBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<AudioControlBloc>(),
                  ),
                ],
                child: const DashatarShareDialog(),
              ),
            );
          });
        }
      },
      child: ResponsiveLayoutBuilder(
        small: (_, child) => SizedBox.square(
          key: const Key('dashatar_puzzle_board_small'),
          dimension: _BoardSize.small,
          child: child,
        ),
        medium: (_, child) => SizedBox.square(
          key: const Key('dashatar_puzzle_board_medium'),
          dimension: _BoardSize.medium,
          child: child,
        ),
        large: (_, child) => SizedBox.square(
          key: const Key('dashatar_puzzle_board_large'),
          dimension: _BoardSize.large,
          child: child,
        ),
        child: (_) => Stack(children: widget.tiles),
      ),
    );
  }
}
