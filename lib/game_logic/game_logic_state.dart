import 'package:equatable/equatable.dart';
import 'package:tig_tag_toe/game_logic/grid_item.dart';

abstract class GameLogicState extends Equatable {
  GameLogicState(this.version);

  final int version;

  @override
  List<Object> get props => [version];
}

/// UnInitialized
class UnGameLogicState extends GameLogicState {
  UnGameLogicState(int version) : super(version);

  @override
  String toString() => 'UnGameLogicState';
}

/// Initialized
class InGameLogicState extends GameLogicState {
  final GameLogicModel gameLogicModel;

  InGameLogicState(int version, {required this.gameLogicModel}) : super(version);

  GameLogicModel get model => gameLogicModel;

  InGameLogicState copyWith({GameLogicModel? gameLogicModel}) {
    return InGameLogicState(
      version + 1,
      gameLogicModel: gameLogicModel ?? this.gameLogicModel,
    );
  }

  @override
  String toString() => 'InGameLogicState';
}

class GameLogicModel extends Equatable {
  final topFields = List.generate(3, (i) => List.generate(3, (j) => GridItem.topLevelField(i, j)));

  GridItem itemGridByCoordinates({required int i, required int j}) {
    return topFields[i][j];
  }

  @override
  List<Object> get props => [];
}
