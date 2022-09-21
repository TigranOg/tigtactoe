import 'package:equatable/equatable.dart';

enum ItemState { X, O, empty }

class Game3x3Model extends Equatable {
  final spaces = List.generate(
      3, (i) => List.generate(3, (j) => SpaceItem(row: i, col: j)));

  SpaceItem spaceByCoordinates({required int row, required int col}) {
    return spaces[row][col];
  }

  @override
  List<Object> get props => [];
}

class SpaceItem {
  SpaceItem({required this.col, required this.row})
      : itemState = ItemState.empty;

  final int row, col;
  ItemState itemState;
}
