import 'package:equatable/equatable.dart';

abstract class GameLogicState extends Equatable {
  GameLogicState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class UnGameLogicState extends GameLogicState {
  UnGameLogicState();

  @override
  String toString() => 'UnGameLogicState';
}

/// Initialized
class InGameLogicState extends GameLogicState {
  InGameLogicState(this.hello);

  final String hello;

  @override
  String toString() => 'InGameLogicState $hello';

  @override
  List<Object> get props => [hello];
}
