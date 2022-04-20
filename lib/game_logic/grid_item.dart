enum ItemState { X, O, empty }

class GridItem {
  int i, j;
  ItemState itemState;
  List<List>? innerField;

  bool get isTopLevelField => innerField != null;

  GridItem.topLevelField(this.i, this.j)
      : itemState = ItemState.empty,
        innerField = List.generate(3, (i) => List.generate(3, (j) => GridItem.innerLevelField(i, j)));

  GridItem.innerLevelField(this.i, this.j) : itemState = ItemState.empty;
}
