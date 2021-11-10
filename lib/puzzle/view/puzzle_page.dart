// ignore_for_file: public_member_api_docs
// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

class PuzzlePage extends StatelessWidget {
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(ticker: const Ticker()),
      child: BlocProvider(
        create: (context) => ThemeBloc(
          themes: const [
            BlueTheme(),
            RedTheme(),
          ],
        ),
        child: const PuzzleView(),
      ),
    );
  }
}

class PuzzleView extends StatelessWidget {
  const PuzzleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    return theme.appScaffold(
      body: BlocProvider(
        create: (context) => PuzzleBloc(4)..add(const PuzzleInitialized()),
        child: Center(
          child: SizedBox(
            width: 580,
            child: theme.puzzleWrapper(child: const _Puzzle()),
          ),
        ),
      ),
    );
  }
}

class _Puzzle extends StatelessWidget {
  const _Puzzle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        _PuzzleThemeTabBar(),
        _PuzzleBoard(),
        _PuzzleInformation(),
      ],
    );
  }
}

class _PuzzleThemeTabBar extends StatelessWidget {
  const _PuzzleThemeTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themes = context.read<ThemeBloc>().themes;
    final currentTheme = context.select((ThemeBloc bloc) => bloc.state.theme);

    return DefaultTabController(
      initialIndex: themes.indexOf(currentTheme),
      length: themes.length,
      child: currentTheme.themeTabBar(
        themes: themes,
        onTap: (index) {
          context.read<ThemeBloc>().add(ThemeChanged(themeIndex: index));
        },
      ),
    );
  }
}

class _PuzzleBoard extends StatelessWidget {
  const _PuzzleBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);
    final size = puzzle.getDimension();
    if (size == 0) return const CircularProgressIndicator();

    return Flexible(
      child: theme.puzzleBoard(
        size: size,
        children: puzzle.tiles.map((tile) => _PuzzleTile(tile: tile)).toList(),
      ),
    );
  }
}

class _PuzzleInformation extends StatelessWidget {
  const _PuzzleInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        _ResetButton(),
        _MovesCounter(),
        _TilesLeftCounter(),
        _Timer(),
      ],
    );
  }
}

class _PuzzleTile extends StatelessWidget {
  const _PuzzleTile({Key? key, required this.tile}) : super(key: key);

  final Tile tile;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    return BlocListener<PuzzleBloc, PuzzleState>(
      listener: (context, state) {
        if (state.puzzleStatus == PuzzleStatus.complete) {
          final completedInSeconds =
              context.read<TimerBloc>().state.secondsElapsed;
          context.read<TimerBloc>().add(TimerStopped(completedInSeconds));
        }
      },
      child: GestureDetector(
        onTap: () {
          final numberOfMoves = context.read<PuzzleBloc>().state.numberOfMoves;
          if (numberOfMoves == 0) {
            context.read<TimerBloc>().add(const TimerStarted());
          }
          context.read<PuzzleBloc>().add(TileTapped(tile));
        },
        child: (!tile.isWhitespace)
            ? theme.tile(tile.value)
            : const _WhitespaceTile(),
      ),
    );
  }
}

class _WhitespaceTile extends StatelessWidget {
  const _WhitespaceTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isComplete =
        context.select((PuzzleBloc bloc) => bloc.state.puzzleStatus) ==
            PuzzleStatus.complete;
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    return isComplete ? theme.whitespaceTileComplete : theme.whitespaceTile;
  }
}

class _ResetButton extends StatelessWidget {
  const _ResetButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    return GestureDetector(
      onTap: () {
        context.read<PuzzleBloc>().add(const PuzzleReset());
        context.read<TimerBloc>().add(const TimerReset());
      },
      child: theme.resetIcon,
    );
  }
}

class _MovesCounter extends StatelessWidget {
  const _MovesCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final moves = context.select((PuzzleBloc bloc) => bloc.state.numberOfMoves);
    return Expanded(child: theme.movesCounter(moves));
  }
}

class _TilesLeftCounter extends StatelessWidget {
  const _TilesLeftCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final numberOfTiles =
        context.select((PuzzleBloc bloc) => bloc.state.puzzle.tiles.length);
    final numberOfCorrectTiles =
        context.select((PuzzleBloc bloc) => bloc.state.numberOfCorrectTiles);
    final numberOfTilesLeft = numberOfTiles - numberOfCorrectTiles - 1;
    return Expanded(child: theme.tilesLeftCounter(numberOfTilesLeft));
  }
}

class _Timer extends StatelessWidget {
  const _Timer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    final seconds =
        context.select((TimerBloc bloc) => bloc.state.secondsElapsed);
    return Expanded(child: theme.timer(seconds));
  }
}
