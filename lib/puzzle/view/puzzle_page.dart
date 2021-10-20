// ignore_for_file: public_member_api_docs
// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

// This is all dummy UI just for manual testing purposes. The app's actual UI
// will be implemented after all the logic components are complete.

class PuzzlePage extends StatelessWidget {
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 180),
        child: Center(
          child: BlocProvider(
            create: (context) => PuzzleBloc(4)..add(const PuzzleInitialized()),
            child: const _PuzzleBoard(),
          ),
        ),
      ),
      backgroundColor: Colors.blue.shade100,
    );
  }
}

class _PuzzleBoard extends StatelessWidget {
  const _PuzzleBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(ticker: const Ticker()),
      child: Column(
        children: const [
          _PuzzleGrid(),
          _PuzzleControls(),
        ],
      ),
    );
  }
}

class _PuzzleGrid extends StatelessWidget {
  const _PuzzleGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);
    final size = puzzle.getDimension();
    if (size == 0) return const CircularProgressIndicator();

    return SizedBox(
      height: 500,
      child: GridView.count(
        crossAxisCount: size,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: [for (final tile in puzzle.tiles) _PuzzleTile(tile: tile)],
      ),
    );
  }
}

class _PuzzleControls extends StatelessWidget {
  const _PuzzleControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tiles = context.select((PuzzleBloc bloc) => bloc.state.puzzle.tiles);
    final moves = context.select((PuzzleBloc bloc) => bloc.state.numberOfMoves);
    final numberOfCorrectTiles =
        context.select((PuzzleBloc bloc) => bloc.state.numberOfCorrectTiles);
    final numberOfTilesLeft = tiles.length - numberOfCorrectTiles - 1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            context.read<PuzzleBloc>().add(const PuzzleReset());
            context.read<TimerBloc>().add(const TimerReset());
          },
          icon: const Icon(Icons.refresh_rounded),
        ),
        SizedBox(
          height: 30,
          child: Text(
            '$moves Moves',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: Text(
            '$numberOfTilesLeft Tiles left',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
          child: _Timer(),
        ),
      ],
    );
  }
}

class _PuzzleTile extends StatelessWidget {
  const _PuzzleTile({Key? key, required this.tile}) : super(key: key);

  final Tile tile;

  @override
  Widget build(BuildContext context) {
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
            ? _ValueTile(value: tile.value)
            : const _WhitespaceTile(),
      ),
    );
  }
}

class _ValueTile extends StatelessWidget {
  const _ValueTile({Key? key, required this.value}) : super(key: key);

  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: Text(
          '$value',
          style: const TextStyle(fontSize: 30),
        ),
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: isComplete ? const _CompleteIcon() : const SizedBox(),
      ),
    );
  }
}

class _CompleteIcon extends StatelessWidget {
  const _CompleteIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.thumb_up,
      size: 70,
      color: Colors.blue,
    );
  }
}

class _Timer extends StatelessWidget {
  const _Timer({Key? key}) : super(key: key);

  String format(Duration d) => d.toString().split('.').first.padLeft(8, '0');

  @override
  Widget build(BuildContext context) {
    final seconds =
        context.select((TimerBloc bloc) => bloc.state.secondsElapsed);
    return Text(
      format(Duration(seconds: seconds)),
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
