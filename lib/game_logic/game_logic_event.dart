import 'dart:async';
import 'dart:developer';

import 'package:tig_tag_toe/game_logic/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GameLogicEvent {
  Stream<GameLogicState> applyAsync({GameLogicState currentState, GameLogicBloc bloc});
}

class UnGameLogicEvent extends GameLogicEvent {
  @override
  Stream<GameLogicState> applyAsync({GameLogicState? currentState, GameLogicBloc? bloc}) async* {
    yield UnGameLogicState();
  }
}

class LoadGameLogicEvent extends GameLogicEvent {
  @override
  Stream<GameLogicState> applyAsync({GameLogicState? currentState, GameLogicBloc? bloc}) async* {
    try {
      yield UnGameLogicState();
      await Future.delayed(const Duration(seconds: 1));
      yield InGameLogicState('Hello world');
    } catch (_, stackTrace) {
      log('$_', name: 'LoadGameLogicEvent', error: _, stackTrace: stackTrace);
    }
  }
}
