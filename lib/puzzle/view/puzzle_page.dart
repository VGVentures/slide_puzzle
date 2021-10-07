// ignore_for_file: public_member_api_docs
// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/bloc/puzzle_bloc.dart';

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
        child: Center(child: PuzzleBoard()),
      ),
      backgroundColor: Colors.blue.shade100,
    );
  }
}

class PuzzleBoard extends StatelessWidget {
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        PuzzleGrid(),
        PuzzleControls(),
      ],
    );
  }
}

class PuzzleGrid extends StatelessWidget {
  const PuzzleGrid({Key? key}) : super(key: key);

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
          children: [for (var tile in puzzle.tiles) TileWidget(tile: tile)],
        ),
      );
    }
  }
}

class TileWidget extends StatelessWidget {
  const TileWidget({Key? key, required this.tile}) : super(key: key);

  final Tile tile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<PuzzleBloc>().add(TileTapped(tile)),
      child: Container(
        decoration: BoxDecoration(
          color: (!tile.isWhitespace) ? Colors.blue : Colors.blue.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(
          child: (!tile.isWhitespace)
              ? Text(
                  '${tile.value}',
                  style: const TextStyle(fontSize: 30),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}

class PuzzleControls extends StatelessWidget {
  const PuzzleControls({Key? key}) : super(key: key);

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
