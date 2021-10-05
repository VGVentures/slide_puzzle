// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/models.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc(this._size, {this.random}) : super(const PuzzleState()) {
    on<PuzzleInitialized>(_onInitialize);
    on<TileTapped>(_onTileTapped);
  }

  final int _size;

  final Random? random;

  void _onInitialize(PuzzleInitialized event, Emitter<PuzzleState> emit) {
    final puzzle = _generatePuzzle(_size);
    emit(state.copyWith(puzzle: puzzle));
  }

  void _onTileTapped(TileTapped event, Emitter<PuzzleState> emit) {
    final tappedTile = event.tile;
    if (_isMovable(tappedTile)) {
      final puzzle = _moveTiles(
        Puzzle(tiles: [...state.puzzle.tiles]),
        tappedTile,
        [],
      );
      emit(state.copyWith(
        puzzle: puzzle,
        tileMovementStatus: TileMovementStatus.moved,
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
    for (var x = 1; x <= size; x++) {
      for (var y = 1; y <= size; y++) {
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
    // coverage:ignore-start
    while (!puzzle.isSolvable()) {
      currentPositions.shuffle(random);
      tiles = _getTileListFromPositions(
        size,
        correctPositions,
        currentPositions,
      );
      puzzle = Puzzle(tiles: tiles);
    }
    // coverage:ignore-end

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

  Tile _getWhitespaceTile(Puzzle puzzle) {
    return puzzle.tiles.singleWhere((tile) => tile.value == 0);
  }

  bool _isMovable(Tile tile) {
    final whitespaceTile = _getWhitespaceTile(state.puzzle);
    if (tile == whitespaceTile) {
      return false;
    }

    // A tile must be in the same row or column as the whitespace to move.
    if (whitespaceTile.currentPosition.x != tile.currentPosition.x &&
        whitespaceTile.currentPosition.y != tile.currentPosition.y) {
      return false;
    }
    return true;
  }

  /// Shifts one or many tiles in a row/column with the whitespace and returns
  /// the modified puzzle.
  ///
  // Recursively stores a list of all tiles that need to be moved and passes the
  // list to _swapTiles to individually swap them.
  Puzzle _moveTiles(Puzzle puzzle, Tile tile, List<Tile> tilesToSwap) {
    final whitespaceTile = _getWhitespaceTile(puzzle);
    final deltaX = whitespaceTile.currentPosition.x - tile.currentPosition.x;
    final deltaY = whitespaceTile.currentPosition.y - tile.currentPosition.y;

    if ((deltaX.abs() + deltaY.abs()) > 1) {
      final shiftPointX = tile.currentPosition.x + deltaX.sign;
      final shiftPointY = tile.currentPosition.y + deltaY.sign;
      final tileToSwapWith = puzzle.tiles.singleWhere(
        (tile) =>
            tile.currentPosition.x == shiftPointX &&
            tile.currentPosition.y == shiftPointY,
      );
      tilesToSwap.add(tile);
      return _moveTiles(puzzle, tileToSwapWith, tilesToSwap);
    } else {
      tilesToSwap.add(tile);
      return _swapTiles(puzzle, tilesToSwap);
    }
  }

  /// Returns puzzle with new tile arrangement after individually swapping each
  /// tile in tilesToSwap with the whitespace.
  Puzzle _swapTiles(Puzzle puzzle, List<Tile> tilesToSwap) {
    final tiles = puzzle.tiles;
    for (final tileToSwap in tilesToSwap.reversed) {
      final tileIndex = tiles.indexOf(tileToSwap);
      final tile = tiles[tileIndex];
      final whitespaceTile = _getWhitespaceTile(puzzle);
      final whitespaceTileIndex = tiles.indexOf(whitespaceTile);

      // Swap current board positions of the moving tile and the whitespace.
      tiles[tileIndex] = tile.copyWith(
        currentPosition: whitespaceTile.currentPosition,
      );
      tiles[whitespaceTileIndex] = whitespaceTile.copyWith(
        currentPosition: tile.currentPosition,
      );
    }

    return Puzzle(tiles: tiles);
  }
}
