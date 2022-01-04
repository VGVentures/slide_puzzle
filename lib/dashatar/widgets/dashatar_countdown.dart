import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';
import 'package:very_good_slide_puzzle/typography/typography.dart';

/// {@template dashatar_countdown}
/// Displays the countdown before the puzzle is started.
/// {@endtemplate}
class DashatarCountdown extends StatelessWidget {
  /// {@macro dashatar_countdown}
  const DashatarCountdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashatarPuzzleBloc, DashatarPuzzleState>(
      listener: (context, state) {
        if (!state.isCountdownRunning) {
          return;
        }

        // Start the puzzle timer when the countdown finishes.
        if (state.status == DashatarPuzzleStatus.started) {
          context.read<TimerBloc>().add(const TimerStarted());
        }

        // Shuffle the puzzle on every countdown tick.
        if (state.secondsToBegin >= 1 && state.secondsToBegin <= 3) {
          context.read<PuzzleBloc>().add(const PuzzleReset());
        }
      },
      child: ResponsiveLayoutBuilder(
        small: (_, __) => const SizedBox(),
        medium: (_, __) => const SizedBox(),
        large: (_, __) => BlocBuilder<DashatarPuzzleBloc, DashatarPuzzleState>(
          builder: (context, state) {
            if (!state.isCountdownRunning || state.secondsToBegin > 3) {
              return const SizedBox();
            }

            if (state.secondsToBegin > 0) {
              return DashatarCountdownSecondsToBegin(
                key: ValueKey(state.secondsToBegin),
                secondsToBegin: state.secondsToBegin,
              );
            } else {
              return const DashatarCountdownGo();
            }
          },
        ),
      ),
    );
  }
}

/// {@template dashatar_countdown_seconds_to_begin}
/// Display how many seconds are left to begin the puzzle.
/// {@endtemplate}
@visibleForTesting
class DashatarCountdownSecondsToBegin extends StatefulWidget {
  /// {@macro dashatar_countdown_seconds_to_begin}
  const DashatarCountdownSecondsToBegin({
    Key? key,
    required this.secondsToBegin,
  }) : super(key: key);

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  @override
  State<DashatarCountdownSecondsToBegin> createState() =>
      _DashatarCountdownSecondsToBeginState();
}

class _DashatarCountdownSecondsToBeginState
    extends State<DashatarCountdownSecondsToBegin>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> inOpacity;
  late Animation<double> inScale;
  late Animation<double> outOpacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    inOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.58, curve: Curves.decelerate),
      ),
    );

    inScale = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.58, curve: Curves.decelerate),
      ),
    );

    outOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.81, 1, curve: Curves.easeIn),
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.select((DashatarThemeBloc bloc) => bloc.state.theme);

    return FadeTransition(
      opacity: outOpacity,
      child: FadeTransition(
        opacity: inOpacity,
        child: ScaleTransition(
          scale: inScale,
          child: Text(
            widget.secondsToBegin.toString(),
            style: PuzzleTextStyle.countdownTime.copyWith(
              color: theme.countdownColor,
            ),
          ),
        ),
      ),
    );
  }
}

/// {@template dashatar_countdown_go}
/// Displays a "Go!" text when the countdown reaches 0 seconds.
/// {@endtemplate}
@visibleForTesting
class DashatarCountdownGo extends StatefulWidget {
  /// {@macro dashatar_countdown_go}
  const DashatarCountdownGo({Key? key}) : super(key: key);

  @override
  State<DashatarCountdownGo> createState() => _DashatarCountdownGoState();
}

class _DashatarCountdownGoState extends State<DashatarCountdownGo>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> inOpacity;
  late Animation<double> inScale;
  late Animation<double> outScale;
  late Animation<double> outOpacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    inOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.37, curve: Curves.decelerate),
      ),
    );

    inScale = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.37, curve: Curves.decelerate),
      ),
    );

    outOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.63, 1, curve: Curves.easeIn),
      ),
    );

    outScale = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.63, 1, curve: Curves.easeIn),
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.select((DashatarThemeBloc bloc) => bloc.state.theme);

    return Padding(
      padding: const EdgeInsets.only(top: 101),
      child: FadeTransition(
        opacity: outOpacity,
        child: FadeTransition(
          opacity: inOpacity,
          child: ScaleTransition(
            scale: outScale,
            child: ScaleTransition(
              scale: inScale,
              child: Text(
                context.l10n.dashatarCountdownGo,
                style: PuzzleTextStyle.countdownTime.copyWith(
                  fontSize: 100,
                  color: theme.defaultColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
