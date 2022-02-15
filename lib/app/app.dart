import 'package:flutter/material.dart';
import 'package:very_good_slide_puzzle/puzzle/view/puzzle_page.dart';

class App extends StatefulWidget {
  const App({Key? key})
      : super(key: key);
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PuzzlePage(),
    );
  }
}
