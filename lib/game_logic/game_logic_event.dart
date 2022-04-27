import 'dart:async';
import 'dart:developer';

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
      log('$_', name: 'LoadGameLogicEvent', error: _, stackTrace: stackTrace);
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
        // await Future.delayed(const Duration(seconds: 1));
        final GameLogicModel model = currentState.model;
        final topField = model.topFields[parentI][parentJ];
        final GridItem innerField = topField.innerFields?[itemI][itemJ];
        innerField.itemState = ItemState.X;

        final InGameLogicState state = currentState.copyWith(gameLogicModel: model);
        yield state;
      }
    } catch (_, stackTrace) {
      log('$_', name: 'MakeMoveEvent', error: _, stackTrace: stackTrace);
    }
  }
}
