import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tig_tag_toe/bloc/game_logic_event.dart';
import 'package:tig_tag_toe/bloc/game_logic_state.dart';

class GameLogicBloc extends Bloc<GameLogicEvent, GameLogicState> {
  GameLogicBloc(): super(InGameState.initial()) {
    on<GameLogicEvent>((event, emit) {
      return emit.forEach<GameLogicState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          return InGameState.initial();
        },
      );
    });
  }
}