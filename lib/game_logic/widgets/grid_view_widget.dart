import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tig_tag_toe/game_logic/grid_item.dart';
import 'package:tig_tag_toe/game_logic/index.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget(
      {required this.topLevel, required this.gameLogicBloc, required this.gameLogicState, this.parentI = -1, this.parentJ = -1, Key? key})
      : super(key: key);
  final bool topLevel;
  final GameLogicBloc gameLogicBloc;
  final InGameLogicState gameLogicState;
  final int parentI, parentJ;

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
                  gameLogicState: gameLogicState,
                  parentI: i,
                  parentJ: j,
                ))
            : Container(
                color: Colors.white,
                child: Center(
                  child: GridItemWidget(
                    key: Key('$i $j $parentI $parentJ'),
                    gameLogicBloc: gameLogicBloc,
                    gameLogicState: gameLogicState,
                    itemI: i,
                    itemJ: j,
                    parentI: parentI,
                    parentJ: parentJ,
                  ),
                ),
              );
      },
    );
  }
}

class GridItemWidget extends StatelessWidget {
  const GridItemWidget(
      {required this.gameLogicBloc,
      required this.gameLogicState,
      required this.itemI,
      required this.itemJ,
      required this.parentI,
      required this.parentJ,
      Key? key})
      : super(key: key);
  final GameLogicBloc gameLogicBloc;
  final InGameLogicState gameLogicState;
  final int itemI, itemJ, parentI, parentJ;

  @override
  Widget build(BuildContext context) {
    final model = gameLogicState.model;
    final topField = model.topFields[parentI][parentJ];
    final GridItem? innerField = topField.innerFields?[itemI][itemJ];

    if (innerField?.itemState != ItemState.empty) {
      log('');
    }

    return Container(
      color: Colors.white,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white, // background
          onPrimary: Colors.red,
        ),
        onPressed: () {
          if (innerField?.itemState == ItemState.empty) {
            gameLogicBloc.add(MakeMoveEvent(itemI: itemI, itemJ: itemJ, parentI: parentI, parentJ: parentJ));
          }
        },
        child: Visibility(
          visible: innerField?.itemState != ItemState.empty,
          child: Text(
            innerField!.itemState.name,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
