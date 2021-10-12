// ignore_for_file: public_member_api_docs
// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';

// This is all dummy UI just for manual testing purposes. The app's actual UI
// will be implemented after all the logic components are complete.

class PuzzlePage extends StatelessWidget {
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PuzzleBloc>().add(const PuzzleInitialized());

    return Scaffold(
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 180),
        child: Center(child: _PuzzleBoard()),
      ),
      backgroundColor: Colors.blue.shade100,
    );
  }
}

class _PuzzleBoard extends StatelessWidget {
  const _PuzzleBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _PuzzleGrid(),
        _PuzzleControls(),
      ],
    );
  }
}

class _PuzzleGrid extends StatelessWidget {
  const _PuzzleGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);
    final size = puzzle.getDimension();
    if (size == 0) {
      return const CircularProgressIndicator();
    } else {
      return SizedBox(
        height: 500,
        child: GridView.count(
          crossAxisCount: size,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: [for (var tile in puzzle.tiles) _PuzzleTile(tile: tile)],
        ),
      );
    }
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
          onPressed: () => context.read<PuzzleBloc>().add(const PuzzleReset()),
          icon: const Icon(
            Icons.refresh_rounded,
          ),
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
      ],
    );
  }
}

class _PuzzleTile extends StatelessWidget {
  const _PuzzleTile({Key? key, required this.tile}) : super(key: key);

  final Tile tile;

  @override
  Widget build(BuildContext context) {
    final state = context.select((PuzzleBloc bloc) => bloc.state);
    if (state is PuzzleComplete) {
      return (!tile.isWhitespace)
          ? _ValueTile(value: tile.value)
          : const _WhitespaceTile(whitespaceWidget: _CompleteIcon());
    }
    return GestureDetector(
      onTap: () => context.read<PuzzleBloc>().add(TileTapped(tile)),
      child: (!tile.isWhitespace)
          ? _ValueTile(value: tile.value)
          : const _WhitespaceTile(whitespaceWidget: SizedBox()),
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
  const _WhitespaceTile({Key? key, required this.whitespaceWidget})
      : super(key: key);

  final Widget whitespaceWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: whitespaceWidget,
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
