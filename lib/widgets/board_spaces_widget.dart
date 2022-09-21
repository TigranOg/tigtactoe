import 'package:flutter/material.dart';
import 'package:tig_tag_toe/bloc/index.dart';

class BoardSpaces3x3Widget extends StatelessWidget {
  const BoardSpaces3x3Widget({required this.currentState, required this.bloc, Key? key}) : super(key: key);

  final GameLogicState currentState;
  final GameLogicBloc bloc;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        int row = (index / 3).floor();
        int col = index % 3;
        SpaceItem spaceItem = currentState.model.spaceByCoordinates(row: row, col: col);

        return GestureDetector(
          onTap: () {
            if (spaceItem.itemState == ItemState.empty) bloc.add(MakeMove(row: row, col: col));
          },
          child: getSpace(currentState, spaceItem),
        );
      },
    );
  }

  Widget getSpace(GameLogicState currentState, SpaceItem spaceItem) {
    if (spaceItem.itemState == ItemState.X) {
      return Container(color: Colors.blueAccent);
    }
    if (spaceItem.itemState == ItemState.O) {
      return Container(color: Colors.redAccent);
    }

    return Container(color: Colors.black12);
  }
}
