import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/position.dart';

/// {@template tile}
/// Model for a puzzle tile.
/// {@endtemplate}
class Tile extends Equatable {
  /// {@macro tile}
  const Tile({
    required this.value,
    required this.correctPosition,
    required this.currentPosition,
    this.isWhitespace = false,
    required this.tileColor
  });

  /// Value representing the correct position of [Tile] in a list.
  final int value;

  /// The correct 2D [Position] of the [Tile]. All tiles must be in their
  /// correct position to complete the puzzle.
  final Position correctPosition;

  /// The current 2D [Position] of the [Tile].
  final Position currentPosition;

  /// Denotes if the [Tile] is the whitespace tile or not.
  final bool isWhitespace;

  /// Color of the tile
  final Color tileColor;

  /// Create a copy of this [Tile] with updated current position.
  Tile copyWith({required Position currentPosition}) {
    return Tile(
      value: value,
      correctPosition: correctPosition,
      currentPosition: currentPosition,
      isWhitespace: isWhitespace,
      tileColor: tileColor
    );
  }

  @override
  List<Object> get props => [
    value,
    correctPosition,
    currentPosition,
    isWhitespace,
  ];
}
