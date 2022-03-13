// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/rotade/rotade.dart';
import 'package:very_good_slide_puzzle/simple/simple_theme.dart';
import 'package:very_good_slide_puzzle/theme/themes/puzzle_theme.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc(this._size, {this.random, this.theme})
      : super(const PuzzleState()) {
    on<PuzzleInitialized>(_onPuzzleInitialized);
    on<TileTapped>(_onTileTapped);
    on<PuzzleReset>(_onPuzzleReset);
    on<TilesRotated>(_onTilesRotated);
  }

  final int _size;

  final PuzzleTheme? theme;

  final Random? random;

  void _onPuzzleInitialized(
    PuzzleInitialized event,
    Emitter<PuzzleState> emit,
  ) {
    final puzzle = _generatePuzzle(_size, shuffle: event.shufflePuzzle);
    emit(
      PuzzleState(
        puzzle: puzzle.sort(),
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
      ),
    );
  }

  void _onTileTapped(TileTapped event, Emitter<PuzzleState> emit) {
    final tappedTile = event.tile;
    if (state.puzzleStatus == PuzzleStatus.incomplete) {
      if (state.puzzle.isTileMovable(tappedTile)) {
        final mutablePuzzle = Puzzle(tiles: [...state.puzzle.tiles]);
        final puzzle = mutablePuzzle.moveTiles(tappedTile, []);
        if (puzzle.isComplete()) {
          emit(
            state.copyWith(
              puzzle: puzzle.sort(),
              puzzleStatus: PuzzleStatus.complete,
              tileMovementStatus: TileMovementStatus.moved,
              numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
              numberOfMoves: state.numberOfMoves + 1,
              lastTappedTile: tappedTile,
            ),
          );
        } else {
          emit(
            state.copyWith(
              puzzle: puzzle.sort(),
              tileMovementStatus: TileMovementStatus.moved,
              numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
              numberOfMoves: state.numberOfMoves + 1,
              lastTappedTile: tappedTile,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
        );
      }
    } else {
      emit(
        state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
      );
    }
  }

  void _onTilesRotated(TilesRotated event, Emitter<PuzzleState> emit) {
    if (state.puzzleStatus == PuzzleStatus.incomplete) {
      final mutablePuzzle = Puzzle(tiles: [...state.puzzle.tiles]);
      // final puzzle = mutablePuzzle.moveTiles(tappedTile, []);

      final puzzle = mutablePuzzle.rotateTiles(event.index);

      if (puzzle.isComplete()) {
        emit(
          state.copyWith(
            puzzle: puzzle.sort(),
            puzzleStatus: PuzzleStatus.complete,
            tileMovementStatus: TileMovementStatus.moved,
            numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
            numberOfMoves: state.numberOfMoves + 1,
            // lastTappedTile: tappedTile,
          ),
        );
      } else {
        emit(
          state.copyWith(
            puzzle: puzzle.sort(),
            tileMovementStatus: TileMovementStatus.moved,
            numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
            numberOfMoves: state.numberOfMoves + 1,
            // lastTappedTile: tappedTile,
          ),
        );
      }
    }
  }

  void _onPuzzleReset(PuzzleReset event, Emitter<PuzzleState> emit) {
    final puzzle = _generatePuzzle(_size);
    emit(
      PuzzleState(
        puzzle: puzzle.sort(),
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
      ),
    );
  }

  /// Build a randomized, solvable puzzle of the given size.
  Puzzle _generatePuzzle(int size, {bool shuffle = true}) {
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

    // TODO(prabowomurti): another workaround to determine current theme
    final isRotadeTheme = state.lastTappedTile == null;

    if (shuffle && !isRotadeTheme) {
      // Randomize only the current tile posistions.
      currentPositions.shuffle(random);
    }

    var tiles = _getTileListFromPositions(
      size,
      correctPositions,
      currentPositions,
    );

    var puzzle = Puzzle(tiles: tiles);

    if (shuffle) {
      if (isRotadeTheme) {
        var rotadeTilePositions = currentPositions;
        while (puzzle.getNumberOfCorrectTiles() != 0) {
          rotadeTilePositions = _randomizeTiles(rotadeTilePositions, size);
          tiles = _getTileListFromPositions(
            size,
            correctPositions,
            rotadeTilePositions,
          );
          puzzle = Puzzle(tiles: tiles);
        }
      } else {
        // Assign the tiles new current positions until the puzzle is solvable and
        // zero tiles are in their correct position.
        while (!puzzle.isSolvable() || puzzle.getNumberOfCorrectTiles() != 0) {
          currentPositions.shuffle(random);
          tiles = _getTileListFromPositions(
            size,
            correctPositions,
            currentPositions,
          );
          puzzle = Puzzle(tiles: tiles);
        }
      }
    }

    return puzzle;
  }

  /// Simulating rotate tiles for the puzzle
  List<Position> _randomizeTiles(List<Position> _positions, int size) {
    final rotadeSize = _getNumberOfRotadeElements(size);

    // generate list of rotade btn index
    final rotades = List<int>.generate(rotadeSize, (i) => i);
    final randomRotadeIndex = (rotades..shuffle()).first;
    final topLeftIndex = (randomRotadeIndex ~/ (size - 1)) * size +
        (randomRotadeIndex % (size - 1));

    return _rotateTiles(_positions, topLeftIndex, size);
  }

  /// Get number of rotade elements
  int _getNumberOfRotadeElements(int size) {
    return (size - 1) * (size - 1);
  }

  /// Rotate 4 tiles start from [topLeftIndex], randomly
  //   ┌──────┐ ┌──────┐
  //   │ tli  │ │ tli+1|
  //   └──────┘ └──────┘
  //      [rotadeBtn]
  //   ┌──────┐ ┌──────┐
  //   │ tl+s │ │tl+s+1│
  //   └──────┘ └──────┘
  List<Position> _rotateTiles(
    List<Position> pos,
    int topLeftIndex,
    int tileSize,
  ) {
    // random rotation
    final randomRotate = ([90, 180, 270]..shuffle()).first;

    final topLeft = topLeftIndex;
    final topRight = topLeft + 1;
    final bottomLeft = topLeft + tileSize;
    final bottomRight = bottomLeft + 1;

    switch (randomRotate) {
      case 90:
        final temp = pos[topRight];
        pos[topRight] = pos[bottomRight];
        pos[bottomRight] = pos[bottomLeft];
        pos[bottomLeft] = pos[topLeft];
        pos[topLeft] = temp;
        break;

      case 180:
        final temp1 = pos[topLeft];
        pos[topLeft] = pos[bottomRight];
        pos[bottomRight] = temp1;

        final temp2 = pos[topRight];
        pos[topRight] = pos[bottomLeft];
        pos[bottomLeft] = temp2;
        break;

      case 270: // equals to -90
        final temp = pos[bottomLeft];
        pos[bottomLeft] = pos[bottomRight];
        pos[bottomRight] = pos[topRight];
        pos[topRight] = pos[topLeft];
        pos[topLeft] = temp;

        break;
    }

    return pos;
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
      for (int i = 1; i <= size * size; i++)
        if (i == size * size)
          Tile(
            value: i,
            correctPosition: whitespacePosition,
            currentPosition: currentPositions[i - 1],
            isWhitespace: true,
          )
        else
          Tile(
            value: i,
            correctPosition: correctPositions[i - 1],
            currentPosition: currentPositions[i - 1],
          )
    ];
  }
}
