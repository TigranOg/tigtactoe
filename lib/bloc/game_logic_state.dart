import 'package:equatable/equatable.dart';
import 'package:tig_tag_toe/bloc/game_logic_model.dart';

abstract class GameLogicState extends Equatable {
  const GameLogicState(this.version, this.gameModel);

  final int version;
  final Game3x3Model gameModel;

  Game3x3Model get model => gameModel;

  @override
  List<Object> get props => [version];
}

class InGameState extends GameLogicState {
  const InGameState({required int version, required gameModel}) : super(version, gameModel);

  InGameState.initial() : super(0, Game3x3Model());

  InGameState copyWith({required Game3x3Model gameModel}) {
    return InGameState(
      version: version + 1,
      gameModel: gameModel,
    );
  }
}

class WinState extends GameLogicState  {
  const WinState({required this.evaluation, required gameModel}) : super(0, gameModel);

  final int evaluation;

  bool xWon() {
    return evaluation == 10;
  }
}

