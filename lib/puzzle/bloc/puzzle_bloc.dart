// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/util/util.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc(this._size) : super(const PuzzleState()) {
    on<Initialize>(_onInitialize);
    on<TileTapped>(_onTileTapped);
  }

  final int _size;

  void _onInitialize(Initialize event, Emitter<PuzzleState> emit) {
    final tiles = _generatePuzzle(_size);
    emit(state.copyWith(tiles: tiles));
  }

  void _onTileTapped(TileTapped event, Emitter<PuzzleState> emit) {
    final tappedTile = event.tile;
    if (_isMovable(tappedTile)) {
      final tiles = _moveTiles([...state.tiles], tappedTile, []);
      emit(state.copyWith(
        tiles: tiles,
        tileMovementStatus: TileMovementStatus.moved,
      ));
    } else {
      emit(
        state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
      );
    }
  }

  /// Build a randomized, solvable tile arrangement of the given size.
  List<Tile> _generatePuzzle(int size) {
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
    currentPositions.shuffle();

    // Build list of tiles - giving each tile their correct position and one of
    // the randomized current positions.
    var tiles = [
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

    // Assign new current positions until the tile arrangement is solvable.
    // coverage:ignore-start
    while (!isSolvable(size: size, tiles: tiles)) {
      currentPositions.shuffle();
      tiles = [
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
    // coverage:ignore-end

    return tiles;
  }

  Tile _getWhitespaceTile(List<Tile> tiles) {
    return tiles.singleWhere((tile) => tile.value == 0);
  }

  bool _isMovable(Tile tile) {
    final whitespaceTile = _getWhitespaceTile(state.tiles);
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

  /// Shifts one or many tiles in a row/column with the whitespace.
  ///
  // Recursively stores a list of all tiles that need to be moved and passes the
  // list to _swapTiles to individually swap them
  List<Tile> _moveTiles(List<Tile> tiles, Tile tile, List<Tile> tilesToSwap) {
    final whitespaceTile = _getWhitespaceTile(tiles);
    final deltaX = whitespaceTile.currentPosition.x - tile.currentPosition.x;
    final deltaY = whitespaceTile.currentPosition.y - tile.currentPosition.y;

    if ((deltaX.abs() + deltaY.abs()) > 1) {
      final shiftPointX = tile.currentPosition.x + deltaX.sign;
      final shiftPointY = tile.currentPosition.y + deltaY.sign;
      final tileToSwapWith = tiles.singleWhere((tile) =>
          tile.currentPosition.x == shiftPointX &&
          tile.currentPosition.y == shiftPointY);
      tilesToSwap.add(tile);
      return _moveTiles(tiles, tileToSwapWith, tilesToSwap);
    } else {
      tilesToSwap.add(tile);
      return _swapTiles(tiles, tilesToSwap);
    }
  }

  /// Returns the new tile arrangement after individually swapping each tile
  /// in tilesToSwap with the whitespace.
  List<Tile> _swapTiles(List<Tile> tiles, List<Tile> tilesToSwap) {
    tilesToSwap = tilesToSwap.reversed.toList();

    for (final tileToSwap in tilesToSwap) {
      final tileIndex = tiles.indexOf(tileToSwap);
      final tile = tiles[tileIndex];
      final whitespaceTile = _getWhitespaceTile(tiles);
      final whitespaceTileIndex = tiles.indexOf(whitespaceTile);

      // Swap current board positions of the moving tile and the whitespace.
      tiles[tileIndex] = Tile(
        value: tile.value,
        correctPosition: tile.correctPosition,
        currentPosition: whitespaceTile.currentPosition,
      );
      tiles[whitespaceTileIndex] = Tile(
        value: whitespaceTile.value,
        correctPosition: whitespaceTile.correctPosition,
        currentPosition: tile.currentPosition,
      );
    }

    return tiles;
  }
}
