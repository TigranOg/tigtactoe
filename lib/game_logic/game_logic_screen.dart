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
                  )),
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
