// ignore_for_file: public_member_api_docs
// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

// Placeholder theme until we have designs to implement.

class BlueTheme extends PuzzleTheme {
  const BlueTheme();

  @override
  String get name => 'Blue';

  @override
  Scaffold appScaffold({required Widget body}) {
    return Scaffold(
      body: body,
      backgroundColor: Colors.blue.shade100,
    );
  }

  @override
  Widget puzzleWrapper({required Widget child}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: child,
    );
  }

  @override
  GridView puzzleBoard({required int size, required List<Widget> children}) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: size,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: children,
    );
  }

  @override
  TabBar themeTabBar({
    required List<PuzzleTheme> themes,
    required void Function(int) onTap,
  }) {
    return TabBar(
      tabs: themes
          .map(
            (theme) => Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                theme.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          .toList(),
      indicator: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget tile(int value) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget get whitespaceTile {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: const SizedBox(),
    );
  }

  @override
  Widget get whitespaceTileComplete {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
      ),
      child: const Center(
        child: Icon(
          Icons.thumb_up,
          size: 70,
          color: Colors.blue,
        ),
      ),
    );
  }

  @override
  Widget get resetIcon => const Icon(
        Icons.refresh_rounded,
        color: Colors.white,
      );

  @override
  Widget movesCounter(int moves) {
    return Text(
      '$moves Moves',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget tilesLeftCounter(int tilesLeft) {
    return Text(
      '$tilesLeft Tiles left',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget timer(int seconds) {
    final secondsFormatted =
        Duration(seconds: seconds).toString().split('.').first.padLeft(8, '0');
    return Text(
      secondsFormatted,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  @override
  List<Object> get props => [];
}
