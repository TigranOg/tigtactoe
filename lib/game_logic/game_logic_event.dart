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
        final GridItem innerField = topField.innerFields?[itemI][itemJ];
        innerField.itemState = ItemState.X;

        final InGameLogicState state = currentState.copyWith(gameLogicModel: model);
        yield state;
        await Future.delayed(const Duration(seconds: 2));
        bloc?.add(AIMoveEvent(topFieldI: itemI, topFieldJ: itemJ));
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

          final GridItem innerField = topField.innerFields?[randomI][randomJ];
          if (innerField.itemState == ItemState.empty) {
            innerField.itemState = ItemState.O;
            moveIsDone = true;
          }
        }

        final InGameLogicState state = currentState.copyWith(gameLogicModel: model);
        yield state;
      }
    } catch (_, stackTrace) {
      l.log('$_', name: 'MakeMoveEvent', error: _, stackTrace: stackTrace);
    }
  }
}
