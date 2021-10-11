// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

enum TileMovementStatus { nothingTapped, cannotBeMoved, moved }

abstract class PuzzleState extends Equatable {
  const PuzzleState({
    required this.puzzle,
    required this.tileMovementStatus,
    required this.numberOfCorrectTiles,
    required this.numberOfMoves,
  });

  /// [Puzzle] containing the current tile arrangement.
  final Puzzle puzzle;

  /// Status indicating if a [Tile] was moved or why a [Tile] was not moved.
  final TileMovementStatus tileMovementStatus;

  /// Number of tiles currently in their correct position.
  final int numberOfCorrectTiles;

  /// Number representing how many moves have been made on the current puzzle.
  ///
  /// The number of moves is not always the same as the total number of tiles
  /// moved. If a row/column of 2+ tiles are moved from one tap, one move is
  /// added.
  final int numberOfMoves;

  @override
  List<Object> get props => [
        puzzle,
        tileMovementStatus,
        numberOfCorrectTiles,
        numberOfMoves,
      ];
}

class PuzzleInitial extends PuzzleState {
  const PuzzleInitial()
      : super(
          puzzle: const Puzzle(tiles: []),
          tileMovementStatus: TileMovementStatus.nothingTapped,
          numberOfCorrectTiles: 0,
          numberOfMoves: 0,
        );
}

class PuzzlePlayable extends PuzzleState {
  const PuzzlePlayable({
    required Puzzle puzzle,
    required TileMovementStatus tileMovementStatus,
    required int numberOfCorrectTiles,
    required int numberOfMoves,
  }) : super(
          puzzle: puzzle,
          tileMovementStatus: tileMovementStatus,
          numberOfCorrectTiles: numberOfCorrectTiles,
          numberOfMoves: numberOfMoves,
        );
}

class PuzzleComplete extends PuzzleState {
  const PuzzleComplete({
    required Puzzle puzzle,
    required TileMovementStatus tileMovementStatus,
    required int numberOfCorrectTiles,
    required int numberOfMoves,
  }) : super(
          puzzle: puzzle,
          tileMovementStatus: tileMovementStatus,
          numberOfCorrectTiles: numberOfCorrectTiles,
          numberOfMoves: numberOfMoves,
        );
}
