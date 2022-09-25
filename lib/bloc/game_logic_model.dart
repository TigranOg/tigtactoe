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
      : itemState = ItemState.empty {
    // if (col == 0 && row == 0) {
    //   itemState = ItemState.X;
    // } else if (row == 0 && col == 1) {
    //   itemState = ItemState.O;
    // } else if (row == 1 && col == 0) {
    //   itemState = ItemState.O;
    // } else if (row == 1 && col == 1) {
    //   itemState = ItemState.O;
    // }else if (row == 1 && col == 2) {
    //   itemState = ItemState.X;
    // }else if (row == 2 && col == 0) {
    //   itemState = ItemState.X;
    // }else if (row == 2 && col == 1) {
    //   //itemState = ItemState.X;
    // }
  }

  final int row, col;
  ItemState itemState;
}
