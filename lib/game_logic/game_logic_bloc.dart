import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:tig_tag_toe/game_logic/index.dart';

class GameLogicBloc extends Bloc<GameLogicEvent, GameLogicState> {
  GameLogicBloc(GameLogicState initialState) : super(initialState) {
    on<GameLogicEvent>((event, emit) {
      return emit.forEach<GameLogicState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          log('$error', name: 'GameLogicBloc', error: error, stackTrace: stackTrace);
          return UnGameLogicState(0);
        },
      );
    });
  }
}
