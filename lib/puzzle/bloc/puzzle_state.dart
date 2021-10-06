// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

enum TileMovementStatus { nothingTapped, cannotBeMoved, moved }

class PuzzleState extends Equatable {
  const PuzzleState({
    this.puzzle = const Puzzle(tiles: []),
    this.tileMovementStatus = TileMovementStatus.nothingTapped,
  });

  /// [Puzzle] containing the current tile arrangement.
  final Puzzle puzzle;

  /// Status indicating if a [Tile] was moved or why a [Tile] was not moved.
  final TileMovementStatus tileMovementStatus;

  PuzzleState copyWith({
    Puzzle? puzzle,
    TileMovementStatus? tileMovementStatus,
  }) {
    return PuzzleState(
      puzzle: puzzle ?? this.puzzle,
      tileMovementStatus: tileMovementStatus ?? this.tileMovementStatus,
    );
  }

  @override
  List<Object> get props => [puzzle, tileMovementStatus];
}
