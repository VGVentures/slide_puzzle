// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

/// {@template simple_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [SimpleTheme].
/// {@endtemplate}
class SimplePuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  /// {@macro simple_puzzle_layout_delegate}
  const SimplePuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) => const SizedBox();

  @override
  Widget endSectionBuilder(PuzzleState state) => const SizedBox();

  @override
  Widget backgroundBuilder(PuzzleState state) => const SizedBox();

  @override
  Widget boardBuilder(int size, List<Widget> tiles) => const SizedBox();

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) => const SizedBox();

  @override
  Widget whitespaceTileBuilder() => const SizedBox();

  @override
  List<Object?> get props => [
        startSectionBuilder,
        endSectionBuilder,
        backgroundBuilder,
        boardBuilder,
        tileBuilder,
        whitespaceTileBuilder,
      ];
}
