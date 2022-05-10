import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tig_tag_toe/game_logic/index.dart';
import 'package:tig_tag_toe/game_logic/widgets/grid_view_widget.dart';

class GameLogicScreen extends StatefulWidget {
  const GameLogicScreen({
    required GameLogicBloc gameLogicBloc,
    Key? key,
  })  : _gameLogicBloc = gameLogicBloc,
        super(key: key);

  final GameLogicBloc _gameLogicBloc;

  @override
  GameLogicScreenState createState() {
    return GameLogicScreenState();
  }
}

class GameLogicScreenState extends State<GameLogicScreen> {
  GameLogicScreenState();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameLogicBloc, GameLogicState>(
      bloc: widget._gameLogicBloc,
      builder: (
        BuildContext context,
        GameLogicState currentState,
      ) {
        if (currentState is InGameLogicState) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Card(
                  elevation: 4.0,
                  color: Colors.blueGrey,
                  child: GridViewWidget(
                    topLevel: true,
                    gameLogicBloc: widget._gameLogicBloc,
                    gameLogicState: currentState,
                  )),
            ),
          );
        } else if (currentState is WinState) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(currentState.xWon() ? 'X Won' : 'O won'),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Restart'),
                  onPressed: _load,
                )
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _load() {
    widget._gameLogicBloc.add(LoadGameLogicEvent());
  }
}
