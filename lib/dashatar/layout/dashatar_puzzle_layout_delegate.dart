// TODO(bselwe): Remove this line when the implementation is added.
// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';

/// {@template dashatar_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [DashatarTheme].
/// {@endtemplate}
class DashatarPuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  /// {@macro dashatar_puzzle_layout_delegate}
  const DashatarPuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) {
    return const SizedBox();
  }

  @override
  Widget endSectionBuilder(PuzzleState state) {
    return const SizedBox();
  }

  @override
  Widget backgroundBuilder(PuzzleState state) {
    return const SizedBox();
  }

  @override
  Widget boardBuilder(int size, List<Widget> tiles) {
    return const SizedBox();
  }

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) {
    return const SizedBox();
  }

  @override
  Widget whitespaceTileBuilder() {
    return const SizedBox();
  }

  @override
  List<Object?> get props => [];
}
