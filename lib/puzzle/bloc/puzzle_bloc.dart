// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/models.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc(this._size, {this.random}) : super(const PuzzleState()) {
    on<PuzzleInitialized>(_onPuzzleInitialized);
    on<TileTapped>(_onTileTapped);
  }

  final int _size;

  final Random? random;

  void _onPuzzleInitialized(
      PuzzleInitialized event, Emitter<PuzzleState> emit) {
    final puzzle = _generatePuzzle(_size);
    emit(state.copyWith(
      puzzle: puzzle,
      numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
    ));
  }

  void _onTileTapped(TileTapped event, Emitter<PuzzleState> emit) {
    final tappedTile = event.tile;
    if (state.puzzle.isTileMovable(tappedTile)) {
      final mutablePuzzle = Puzzle(tiles: [...state.puzzle.tiles]);
      final puzzle = mutablePuzzle.moveTiles(tappedTile, []);
      emit(state.copyWith(
        puzzle: puzzle,
        tileMovementStatus: TileMovementStatus.moved,
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
        numberOfMoves: state.numberOfMoves + 1,
      ));
    } else {
      emit(
        state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
      );
    }
  }

  /// Build a randomized, solvable puzzle of the given size.
  Puzzle _generatePuzzle(int size) {
    final correctPositions = <Position>[];
    final currentPositions = <Position>[];
    final whitespacePosition = Position(x: size, y: size);

    // Create all possible board positions.
    for (var y = 1; y <= size; y++) {
      for (var x = 1; x <= size; x++) {
        if (x == size && y == size) {
          correctPositions.add(whitespacePosition);
          currentPositions.add(whitespacePosition);
        } else {
          final position = Position(x: x, y: y);
          correctPositions.add(position);
          currentPositions.add(position);
        }
      }
    }

    // Randomize only the current tile posistions.
    currentPositions.shuffle(random);

    var tiles = _getTileListFromPositions(
      size,
      correctPositions,
      currentPositions,
    );
    var puzzle = Puzzle(tiles: tiles);

    // Assign the tiles new current positions until the puzzle is solvable.
    while (!puzzle.isSolvable()) {
      currentPositions.shuffle(random);
      tiles = _getTileListFromPositions(
        size,
        correctPositions,
        currentPositions,
      );
      puzzle = Puzzle(tiles: tiles);
    }

    return puzzle;
  }

  /// Build a list of tiles - giving each tile their correct position and a
  /// current position.
  List<Tile> _getTileListFromPositions(
    int size,
    List<Position> correctPositions,
    List<Position> currentPositions,
  ) {
    final whitespacePosition = Position(x: size, y: size);
    return [
      for (int i = 0; i < size * size; i++)
        if (i == 0)
          Tile(
            value: i,
            correctPosition: whitespacePosition,
            currentPosition: currentPositions[i],
          )
        else
          Tile(
            value: i,
            correctPosition: correctPositions[i - 1],
            currentPosition: currentPositions[i],
          )
    ];
  }
}
