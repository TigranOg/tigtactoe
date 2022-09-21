import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tig_tag_toe/bloc/index.dart';
import 'package:tig_tag_toe/widgets/board_line_widget.dart';
import 'package:tig_tag_toe/widgets/board_spaces_widget.dart';

class GameBoardScreen extends StatelessWidget {
  GameBoardScreen({Key? key}) : super(key: key);

  final gameLogicBloc = GameLogicBloc();

  @override
  Widget build(BuildContext context) {
    double boardSize = (MediaQuery.of(context).size.width * 0.95).roundToDouble();
    double lineWidth = 6;

    return BlocBuilder<GameLogicBloc, GameLogicState>(
        bloc: gameLogicBloc,
        builder: (
          BuildContext context,
          GameLogicState currentState,
        ) {
          return Center(
            child: SizedBox(
              width: boardSize,
              height: boardSize,
              child: Stack(children: [
                BoardSpaces3x3Widget(
                  currentState: currentState,
                  bloc: gameLogicBloc,
                ),
                //Draw lines
                ...getBoardLines(lineWidth: lineWidth, boardSize: boardSize),
                //Win state UI
                if (currentState is WinState) getWinContainer(bloc: gameLogicBloc, winState: currentState)
              ]),
            ),
          );
        });
  }

  List<Widget> getBoardLines({required double lineWidth, required double boardSize}) {
    return [
      BoardLineWidget.left(width: lineWidth, height: boardSize),
      BoardLineWidget.right(width: lineWidth, height: boardSize),
      BoardLineWidget.top(width: lineWidth, height: boardSize),
      BoardLineWidget.bottom(width: lineWidth, height: boardSize),
    ];
  }
}

Widget getWinContainer({required GameLogicBloc bloc, required WinState winState}) {
  return Align(
    alignment: Alignment.center,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.red, // foreground
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
      ),
      onPressed: () {
        bloc.add(RestartMove());
      },
      child: Text(
        '${winState.xWon() ?'X\'s Won':'O\'s Won'}\nPlay Again',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40,),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
