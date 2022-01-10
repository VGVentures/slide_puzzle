// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/timer/timer.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc(this._size, this.timer, {this.random})
      : super(const PuzzleState()) {
    on<PuzzleInitialized>(_onPuzzleInitialized);
    on<TileTapped>(_onTileTapped);
    on<PuzzleReset>(_onPuzzleReset);
    timer.stream.listen(_onTick);
  }

  final int _size;

  final TimerBloc timer;

  final Random? random;

  void _onTick(TimerState tick) {}

  Future<void> _onPuzzleInitialized(
    PuzzleInitialized event,
    Emitter<PuzzleState> emit,
  ) async {
    final puzzle = _generatePuzzle(_size, shuffle: event.shufflePuzzle);
    timer
      ..add(const TimerStopped())
      ..add(const TimerReset());
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
      if (!timer.state.isRunning) {
        timer.add(const TimerStarted());
      }
      if (state.puzzle.isTileMovable(tappedTile)) {
        final mutablePuzzle = Puzzle(
          tiles: [...state.puzzle.tiles],
          rowsCleared: state.puzzle.rowsCleared,
        );
        final puzzle = mutablePuzzle.moveTile(tappedTile);
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
        } else if (puzzle.isTopRowSolved()) {
          final startValue =
              (puzzle.rowsCleared ~/ _size + 1) * pow(_size, 2).toInt();
          final nextRow = _generateNextRow(
            _size,
            startValue,
            puzzle.rowsCleared + 2,
            puzzle.tiles,
          );
          final newPuzzle = puzzle.pushRow(nextRow);
          timer
            ..add(const TimerReset())
            ..add(const TimerStarted());
          emit(
            state.copyWith(
              puzzle: newPuzzle.sort(),
              tileMovementStatus: TileMovementStatus.rowCleared,
              numberOfCorrectTiles: newPuzzle.getNumberOfCorrectTiles(),
              numberOfMoves: 0,
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

  void _onPuzzleReset(PuzzleReset event, Emitter<PuzzleState> emit) {
    final puzzle = _generatePuzzle(_size);
    timer
      ..add(const TimerStopped())
      ..add(const TimerReset());
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

    if (shuffle) {
      // Randomize only the current tile posistions.
      currentPositions.shuffle(random);
    }

    var tiles = _getTileListFromPositions(
      size,
      correctPositions,
      currentPositions,
    );

    var puzzle = Puzzle(tiles: tiles, rowsCleared: 0);

    if (shuffle) {
      // Assign the tiles new current positions until the puzzle is solvable and
      // zero tiles are in their correct position.
      while (!puzzle.isSolvable() || puzzle.getNumberOfCorrectTiles() != 0) {
        currentPositions.shuffle(random);
        tiles = _getTileListFromPositions(
          size,
          correctPositions,
          currentPositions,
        );
        puzzle = Puzzle(tiles: tiles, rowsCleared: 0);
      }
    }

    return puzzle;
  }

  List<Tile> _generateNextRow(
    int size,
    int startValue,
    int nextRowIndex,
    List<Tile> currentTiles,
  ) {
    int valToRowNum(int v) => ((v - 1) ~/ size) + 1;
    final nextValues = [
      for (int i = startValue; i < startValue + pow(size, 2); i++) i
    ]
      ..removeWhere((v) => currentTiles.any((t) => t.value == v))
      ..shuffle(random)
      // move next row values to the beginning if they are still in the list.
      // otherwise, the next row is unsolvable.
      ..sort((a, b) => valToRowNum(b) == nextRowIndex ? 1 : 0);

    // translate next values into tiles
    final nextRow = <Tile>[];
    var nextPosition = Position(x: 1, y: size);
    for (final value in nextValues.sublist(0, size)) {
      final correctX = (value - 1) % size + 1;
      final correctY = valToRowNum(value);
      final correctPosition = Position(x: correctX, y: correctY);
      nextRow.add(
        Tile(
          value: value,
          currentPosition: nextPosition,
          lastPosition: Position(x: nextPosition.x, y: nextPosition.y + 1),
          correctPosition: correctPosition,
        ),
      );
      nextPosition = Position(x: nextPosition.x + 1, y: nextPosition.y);
    }
    nextRow.shuffle();
    return nextRow;
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
            value: -1,
            correctPosition: whitespacePosition,
            currentPosition: currentPositions[i - 1],
            isWhitespace: true,
            lastPosition: null,
          )
        else
          Tile(
            value: i,
            correctPosition: correctPositions[i - 1],
            currentPosition: currentPositions[i - 1],
            lastPosition: null,
          )
    ];
  }
}
