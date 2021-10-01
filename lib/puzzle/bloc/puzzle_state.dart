// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

enum TileMovementStatus { nothingTapped, cannotBeMoved, moved }

class PuzzleState extends Equatable {
  const PuzzleState({
    this.tiles = const <Tile>[],
    this.tileMovementStatus = TileMovementStatus.nothingTapped,
  });

  /// List of [Tile]s representing the puzzle's current arrangement.
  final List<Tile> tiles;

  /// Status indicating if a [Tile] was moved or why a [Tile] was not moved.
  final TileMovementStatus tileMovementStatus;

  PuzzleState copyWith({
    List<Tile>? tiles,
    TileMovementStatus? tileMovementStatus,
  }) {
    return PuzzleState(
      tiles: tiles ?? this.tiles,
      tileMovementStatus: tileMovementStatus ?? this.tileMovementStatus,
    );
  }

  @override
  List<Object> get props => [tiles, tileMovementStatus];
}
