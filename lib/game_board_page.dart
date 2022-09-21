import 'package:flutter/material.dart';

import 'game_board_screen.dart';

class GameBoardPage extends StatefulWidget {
  const GameBoardPage({Key? key}) : super(key: key);

  @override
  _GameBoardPageState createState() => _GameBoardPageState();
}

class _GameBoardPageState extends State<GameBoardPage> {
  // final _gameBoardBloc = GameBoardBloc(UnGameBoardState(0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tig Tac Toe'),
      ),
      body: GameBoardScreen(),
    );
  }
}