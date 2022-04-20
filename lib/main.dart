import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tig Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tig Tac Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<GridItem>> topLevelField = List.generate(3, (i) => List.generate(3, (j) => GridItem.topLevelField(i, j)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Card(
              elevation: 4.0,
              color: Colors.blueGrey,
              child: GridViewWidget(
                topLevel: true,
              )),
        ),
      ),
    );
  }
}

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({required this.topLevel, Key? key}) : super(key: key);
  final bool topLevel;
  // List<List<GridItem>> field;

  @override
  Widget build(BuildContext context) {
    double spacing = topLevel ? 10 : 4;

    return GridView.builder(
      itemCount: 9,
      shrinkWrap: true,
      padding: topLevel ? const EdgeInsets.all(10.0) : EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemBuilder: (BuildContext context, int index) {
        int i = (index / 3).floor();
        int j = index % 3;

        return topLevel
            ? Container(color: Colors.blue, child: const GridViewWidget(topLevel: false))
            : Container(
                color: Colors.white,
                child: Center(
                    child: GridItemWidget(
                  gridItem: GridItem.innerLevelField(1, 2),
                )),
              );
      },
    );
  }
}

class GridItemWidget extends StatelessWidget {
  const GridItemWidget({required this.gridItem, Key? key}) : super(key: key);
  final GridItem gridItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white, // background
          onPrimary: Colors.red,
        ),
        onPressed: () {},
        child: Container(),
      ),
    );
  }
}

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

class GameField {
  List<List>? innerField;
}
