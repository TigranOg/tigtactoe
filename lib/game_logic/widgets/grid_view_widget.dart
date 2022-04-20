import 'package:flutter/material.dart';
import 'package:tig_tag_toe/game_logic/game_logic_bloc.dart';
import 'package:tig_tag_toe/game_logic/game_logic_event.dart';
import 'package:tig_tag_toe/game_logic/grid_item.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({required this.topLevel, required this.gameLogicBloc, Key? key}) : super(key: key);
  final bool topLevel;
  final GameLogicBloc gameLogicBloc;

  @override
  Widget build(BuildContext context) {
    double spacing = topLevel ? 10 : 4;

    return GridView.builder(
      itemCount: 9,
      shrinkWrap: true,
      padding: topLevel ? const EdgeInsets.all(10.0) : EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemBuilder: (BuildContext context, int index) {
        int i = (index / 3).floor();
        int j = index % 3;

        return topLevel
            ? Container(
                color: Colors.blue,
                child: GridViewWidget(
                  topLevel: false,
                  gameLogicBloc: gameLogicBloc,
                ))
            : Container(
                color: Colors.white,
                child: Center(
                  child: GridItemWidget(
                    gridItem: GridItem.innerLevelField(1, 2),
                    gameLogicBloc: gameLogicBloc,
                  ),
                ),
              );
      },
    );
  }
}

class GridItemWidget extends StatelessWidget {
  const GridItemWidget({required this.gridItem, required this.gameLogicBloc, Key? key}) : super(key: key);
  final GridItem gridItem;
  final GameLogicBloc gameLogicBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white, // background
          onPrimary: Colors.red,
        ),
        onPressed: () {
          gameLogicBloc.add(LoadGameLogicEvent());
        },
        child: Container(),
      ),
    );
  }
}
