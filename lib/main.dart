import 'package:flutter/material.dart';
import 'package:tig_tag_toe/game_board_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tig Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameBoardPage(),
    );
  }
}
