// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

enum TileMovementStatus { nothingTapped, cannotBeMoved, moved }

class PuzzleState extends Equatable {
  const PuzzleState({
    this.puzzle = const Puzzle(tiles: []),
    this.tileMovementStatus = TileMovementStatus.nothingTapped,
    this.numberOfMoves = 0,
  });

  /// [Puzzle] containing the current tile arrangement.
  final Puzzle puzzle;

  /// Status indicating if a [Tile] was moved or why a [Tile] was not moved.
  final TileMovementStatus tileMovementStatus;

  /// Number representing how many moves the player has made on the current
  /// puzzle.
  ///
  /// The number of moves is not always the same as the total number of tiles
  /// moved. If a row/column of 2+ tiles are moved from one tap, one move is
  /// added.
  final int numberOfMoves;

  PuzzleState copyWith({
    Puzzle? puzzle,
    TileMovementStatus? tileMovementStatus,
    int? numberOfMoves,
  }) {
    return PuzzleState(
      puzzle: puzzle ?? this.puzzle,
      tileMovementStatus: tileMovementStatus ?? this.tileMovementStatus,
      numberOfMoves: numberOfMoves ?? this.numberOfMoves,
    );
  }

  @override
  List<Object> get props => [puzzle, tileMovementStatus, numberOfMoves];
}
