import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/models.dart';

/// {@template tile}
/// Model for a puzzle tile.
/// {@endtemplate}
class Tile extends Equatable {
  /// {@macro tile}
  const Tile({
    required this.value,
    required this.correctPosition,
    required this.currentPosition,
    required this.lastPosition,
    this.isWhitespace = false,
  });

  /// Value representing the correct position of [Tile] in a list.
  final int value;

  /// The correct [Position] of the [Tile]. All tiles must be in their
  /// correct position to complete the puzzle. Rather than a 2D position,
  /// the [correctPosition] represents the correct x coordinate,
  /// and the number of the row this tile should be cleared in for the y
  /// coordinate.
  final Position correctPosition;

  /// The current 2D [Position] of the [Tile].
  final Position currentPosition;

  /// The last 2D [Position] of the [Tile]. Null if hasn't been moved.
  final Position? lastPosition;

  /// Denotes if the [Tile] is the whitespace tile or not.
  final bool isWhitespace;

  /// Create a copy of this [Tile] with updated current position.
  Tile copyWith({required Position currentPosition}) {
    return Tile(
      value: value,
      correctPosition: correctPosition,
      currentPosition: currentPosition,
      isWhitespace: isWhitespace,
      lastPosition: currentPosition != this.currentPosition
          ? (lastPosition ?? this.currentPosition)
          : null,
    );
  }

  /// Create a copy of this [Tile] with no last position.
  Tile clearLastPosition() {
    return Tile(
      value: value,
      correctPosition: correctPosition,
      currentPosition: currentPosition,
      isWhitespace: isWhitespace,
      lastPosition: null,
    );
  }

  @override
  List<Object?> get props => [
        value,
        correctPosition,
        currentPosition,
        isWhitespace,
        lastPosition,
      ];
}
