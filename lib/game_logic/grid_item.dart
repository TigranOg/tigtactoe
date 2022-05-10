import 'package:equatable/equatable.dart';

enum ItemState { X, O, empty }

class GridItem extends Equatable {
  int i, j;
  ItemState itemState;
  List<List<GridItem>>? innerFields;

  bool get isTopLevelField => innerFields != null;

  GridItem.topLevelField(this.i, this.j)
      : itemState = ItemState.empty,
        innerFields = List.generate(3, (i) => List.generate(3, (j) => GridItem.withInnerFields(i, j)));

  GridItem.withInnerFields(this.i, this.j) : itemState = ItemState.empty;

  @override
  List<Object?> get props => [itemState];
}
