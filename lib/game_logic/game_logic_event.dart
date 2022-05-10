import 'dart:async';
import 'dart:developer' as l;
import 'dart:math';

import 'package:tig_tag_toe/game_logic/grid_item.dart';
import 'package:tig_tag_toe/game_logic/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GameLogicEvent {
  Stream<GameLogicState> applyAsync({required GameLogicState currentState, GameLogicBloc bloc});
}

class UnGameLogicEvent extends GameLogicEvent {
  @override
  Stream<GameLogicState> applyAsync({GameLogicState? currentState, GameLogicBloc? bloc}) async* {
    yield UnGameLogicState(0);
  }
}

class LoadGameLogicEvent extends GameLogicEvent {
  @override
  Stream<GameLogicState> applyAsync({required GameLogicState currentState, GameLogicBloc? bloc}) async* {
    try {
      yield UnGameLogicState(0);
      await Future.delayed(const Duration(seconds: 1));
      final GameLogicModel model = GameLogicModel();
      yield InGameLogicState(currentState.version + 1, gameLogicModel: model);
    } catch (_, stackTrace) {
      l.log('$_', name: 'LoadGameLogicEvent', error: _, stackTrace: stackTrace);
    }
  }
}

class MakeMoveEvent extends GameLogicEvent {
  final int itemI, itemJ, parentI, parentJ;

  MakeMoveEvent({required this.itemI, required this.itemJ, required this.parentI, required this.parentJ});

  @override
  Stream<GameLogicState> applyAsync({GameLogicState? currentState, GameLogicBloc? bloc}) async* {
    try {
      if (currentState is InGameLogicState) {
        // yield UnGameLogicState();

        final GameLogicModel model = currentState.model;
        final topField = model.topFields[parentI][parentJ];
        final GridItem? innerField = topField.innerFields?[itemI][itemJ];
        innerField?.itemState = ItemState.X;

        int evaluation = MiniMaxAlgo.evaluate(topField.innerFields!);

        // await Future.delayed(const Duration(seconds: 2));
        final GameLogicState state;
        if (evaluation != 0) {
          state = WinState(evaluation: evaluation);
        } else {
          state = currentState.copyWith(gameLogicModel: model);
          bloc?.add(AIMoveEvent(topFieldI: 0, topFieldJ: 0));
        }
        yield state;
      }
    } catch (_, stackTrace) {
      l.log('$_', name: 'MakeMoveEvent', error: _, stackTrace: stackTrace);
    }
  }
}

class AIMoveEvent extends GameLogicEvent {
  final int topFieldI, topFieldJ;

  AIMoveEvent({required this.topFieldI, required this.topFieldJ});

  @override
  Stream<GameLogicState> applyAsync({GameLogicState? currentState, GameLogicBloc? bloc}) async* {
    try {
      if (currentState is InGameLogicState) {
        bool moveIsDone = false;
        final GameLogicModel model = currentState.model;
        final topField = model.topFields[topFieldI][topFieldJ];

        while (!moveIsDone) {
          int randomI = Random().nextInt(3);
          int randomJ = Random().nextInt(3);

          final GridItem? innerField = topField.innerFields?[randomI][randomJ];
          if (innerField?.itemState == ItemState.empty) {
            innerField?.itemState = ItemState.O;
            moveIsDone = true;
          }
        }

        final GameLogicState state;

        int evaluation = MiniMaxAlgo.evaluate(topField.innerFields!);
        if (evaluation != 0) {
          state = WinState(evaluation: evaluation);
        } else {
          state = currentState.copyWith(gameLogicModel: model);
        }

        yield state;
      }
    } catch (_, stackTrace) {
      l.log('$_', name: 'MakeMoveEvent', error: _, stackTrace: stackTrace);
    }
  }
}

class MiniMaxAlgo {
  static int evaluate(List<List<GridItem>> board) {
    //Check rows
    for (int row = 0; row < 3; row++) {
      if (board[row][0] == board[row][1] && board[row][1] == board[row][2]) {
        if (board[row][0].itemState == ItemState.X) {
          return 10;
        } else if (board[row][0].itemState == ItemState.O) {
          return -10;
        }
      }
    }

    //Check columns
    for (int column = 0; column < 3; column++) {
      if (board[0][column] == board[1][column] && board[1][column] == board[2][column]) {
        if (board[0][column].itemState == ItemState.X) {
          return 10;
        } else if (board[0][column].itemState == ItemState.O) {
          return -10;
        }
      }
    }

    //Check diagonals
    if (board[0][0] == board[1][1] && board[1][1] == board[2][2]) {
      if (board[0][0].itemState == ItemState.X) {
        return 10;
      } else if (board[0][0].itemState == ItemState.O) {
        return -10;
      }
    }

    if (board[2][0] == board[1][1] && board[1][1] == board[0][2]) {
      if (board[1][1].itemState == ItemState.X) {
        return 10;
      } else if (board[1][1].itemState == ItemState.O) {
        return -10;
      }
    }

    return 0;
  }
}
