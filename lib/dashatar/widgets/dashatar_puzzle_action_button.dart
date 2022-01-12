import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

/// {@template dashatar_puzzle_action_button}
/// Displays the action button to start or shuffle the puzzle
/// based on the current puzzle state.
/// {@endtemplate}
class DashatarPuzzleActionButton extends StatelessWidget {
  /// {@macro dashatar_puzzle_action_button}
  const DashatarPuzzleActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((DashatarThemeBloc bloc) => bloc.state.theme);

    final status =
        context.select((DashatarPuzzleBloc bloc) => bloc.state.status);
    final isLoading = status == DashatarPuzzleStatus.loading;
    final isStarted = status == DashatarPuzzleStatus.started;

    final text = isStarted
        ? context.l10n.dashatarRestart
        : (isLoading
            ? context.l10n.dashatarGetReady
            : context.l10n.dashatarStartGame);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Tooltip(
        key: ValueKey(status),
        message: isStarted ? context.l10n.puzzleRestartTooltip : '',
        verticalOffset: 40,
        child: PuzzleButton(
          onPressed: isLoading
              ? null
              : () async {
                  final hasStarted = status == DashatarPuzzleStatus.started;

                  // Reset the timer and the countdown.
                  context.read<TimerBloc>().add(const TimerReset());
                  context.read<DashatarPuzzleBloc>().add(
                        DashatarCountdownReset(
                          secondsToBegin: hasStarted ? 5 : 3,
                        ),
                      );

                  // Initialize the puzzle board to show the initial puzzle
                  // (unshuffled) before the countdown completes.
                  if (hasStarted) {
                    context.read<PuzzleBloc>().add(
                          const PuzzleInitialized(shufflePuzzle: false),
                        );
                  }
                },
          textColor: isLoading ? theme.defaultColor : null,
          child: Text(text),
        ),
      ),
    );
  }
}
