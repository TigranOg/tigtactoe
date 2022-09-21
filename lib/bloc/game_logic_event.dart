import 'dart:async';

import 'package:tig_tag_toe/bloc/game_logic_bloc.dart';
import 'package:tig_tag_toe/bloc/game_logic_model.dart';
import 'package:tig_tag_toe/bloc/game_logic_state.dart';

abstract class GameLogicEvent {
  Stream<GameLogicState> applyAsync({required GameLogicState currentState, required GameLogicBloc bloc});
}
class RestartMove extends GameLogicEvent {
  @override
  Stream<GameLogicState> applyAsync({required GameLogicState currentState, required GameLogicBloc bloc}) async* {
    yield InGameState.initial();
  }
}

class MakeMove extends GameLogicEvent {
  MakeMove({required this.row, required this.col});

  final int row, col;

  @override
  Stream<GameLogicState> applyAsync({required GameLogicState currentState, required GameLogicBloc bloc}) async* {
    try {
      if (currentState is InGameState) {
        final Game3x3Model model = currentState.model;

        SpaceItem spaceItem = model.spaceByCoordinates(row: row, col: col);
        spaceItem.itemState = ItemState.X;

        final int evaluation = MiniMaxAlgo.evaluate(model.spaces);

        bool isMovesLeft = MiniMaxAlgo.isMovesLeft(model.spaces);

        final GameLogicState state;
        if (evaluation != 0 || !isMovesLeft) {
          state = WinState(evaluation: evaluation, gameModel: model);
          yield state;
        } else {
          state = currentState.copyWith(gameModel: model);
          yield state;
          bloc.add(AIMove());
        }
      }
    } catch (error, stackTrace) {
      print('$error $stackTrace');
    }
  }
}

class AIMove extends GameLogicEvent {
  @override
  Stream<GameLogicState> applyAsync({required GameLogicState currentState, required GameLogicBloc? bloc}) async* {
    try {
      if (currentState is InGameState) {
        final Game3x3Model model = currentState.model;

        Move move = MiniMaxAlgo.findBestMove(model.spaces, false, 0);

        SpaceItem spaceItem = model.spaceByCoordinates(row: move.row, col: move.col);
        spaceItem.itemState = ItemState.O;

        final int evaluation = MiniMaxAlgo.evaluate(model.spaces);

        final GameLogicState state;
        if (evaluation != 0) {
          state = WinState(evaluation: evaluation, gameModel: model);
        } else {
          state = currentState.copyWith(gameModel: model);
          // bloc?.add(AIMoveEvent(topFieldI: 0, topFieldJ: 0));
        }
        yield state;
      }
    } catch (error, stackTrace) {
      print('$error $stackTrace');
    }
  }
}

class Move {
  Move({required this.row, required this.col});

  final int row, col;
}

class MiniMaxAlgo {
  static Move findBestMove(List<List<SpaceItem>> spaces, bool isMaximizing, int depth) {
    late Move move;

    int bestValue = isMaximizing ? -1000 : 1000;

    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (spaces[row][col].itemState == ItemState.empty) {

          spaces[row][col].itemState = ItemState.O;

          int value = minimax(spaces, !isMaximizing, depth);

          spaces[row][col].itemState = ItemState.empty;

          if (isMaximizing) {
            if (bestValue < value) {
              move = Move(row: row, col: col);
              bestValue = value;
            }
          } else {
            if (bestValue > value) {
              move = Move(row: row, col: col);
              bestValue = value;
            }
          }
        }
      }
    }
    return move;
  }

  static int minimax(List<List<SpaceItem>> spaces, bool isMaximizing, int depth) {
    final int evaluation = MiniMaxAlgo.evaluate(spaces);

    if (evaluation != 0) {
      //TODO add/sub depth
      return evaluation;
    }

    if (isMovesLeft(spaces)) {
      return 0;
    }

    int bestValue = isMaximizing ? -1000 : 1000;

    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        {
          spaces[row][col].itemState = isMaximizing ? ItemState.X : ItemState.O;

          int value = minimax(spaces, !isMaximizing, depth);

          spaces[row][col].itemState = ItemState.empty;

          if (isMaximizing) {
            if (bestValue < value) {
              bestValue = value;
            }
          } else {
            if (bestValue > value) {
              bestValue = value;
            }
          }
        }
      }
    }

    return bestValue;
  }

  static bool isMovesLeft(List<List<SpaceItem>> spaces) {
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (spaces[row][col].itemState == ItemState.empty) {
          return true;
        }
      }
    }

    return false;
  }

  static int evaluate(List<List<SpaceItem>> spaces) {
    //Check rows
    for (int row = 0; row < 3; row++) {
      if (spaces[row][0].itemState == spaces[row][1].itemState && spaces[row][1].itemState == spaces[row][2].itemState) {
        if (spaces[row][0].itemState == ItemState.X) {
          return 10;
        } else if (spaces[row][0].itemState == ItemState.O) {
          return -10;
        }
      }
    }

    //Check columns
    for (int column = 0; column < 3; column++) {
      if (spaces[0][column].itemState == spaces[1][column].itemState && spaces[1][column].itemState == spaces[2][column].itemState) {
        if (spaces[0][column].itemState == ItemState.X) {
          return 10;
        } else if (spaces[0][column].itemState == ItemState.O) {
          return -10;
        }
      }
    }

    //Check diagonals
    if (spaces[0][0].itemState == spaces[1][1].itemState && spaces[1][1].itemState == spaces[2][2].itemState) {
      if (spaces[0][0].itemState == ItemState.X) {
        return 10;
      } else if (spaces[0][0].itemState == ItemState.O) {
        return -10;
      }
    }

    if (spaces[2][0].itemState == spaces[1][1].itemState && spaces[1][1].itemState == spaces[0][2].itemState) {
      if (spaces[1][1].itemState == ItemState.X) {
        return 10;
      } else if (spaces[1][1].itemState == ItemState.O) {
        return -10;
      }
    }

    return 0;
  }
}
