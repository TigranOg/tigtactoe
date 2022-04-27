import 'package:flutter/material.dart';
import 'package:tig_tag_toe/game_logic/index.dart';

class GameLogicPage extends StatefulWidget {
  const GameLogicPage({Key? key}) : super(key: key);

  @override
  _GameLogicPageState createState() => _GameLogicPageState();
}

class _GameLogicPageState extends State<GameLogicPage> {
  final _gameLogicBloc = GameLogicBloc(UnGameLogicState(0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tig Tac Toe'),
      ),
      body: GameLogicScreen(gameLogicBloc: _gameLogicBloc),
    );
  }
}
