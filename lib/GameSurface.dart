import 'package:flutter/material.dart';
import 'constants.dart';
import 'dart:math' as math;

final columns = kGameDifficultyColumns['easy'];
final rows = kGameDifficultyRows['easy'];

class GameSurface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("MinesSweper"),
        ),
        body: SafeArea(child: Mines()));
  }
}

class Mines extends StatefulWidget {
  @override
  _MinesState createState() => _MinesState();
}

class _MinesState extends State<Mines> {
  Text numbers = Text("1");

  List<List> child = gameMatrixList(columns, rows);
  List<List> isDisable = gameMatrixList(columns, rows);

  isButtonDisable(superIndex, index) {
    return (isDisable[superIndex][index] != null)
        ? null
        : () {
            setState(() {
              isDisable[superIndex][index] = true;
            });
          };
  }

  //child[columnCount][rowCount];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Expanded> gridGenerator(superIndex) {
      return List.generate(rows, (index) {
        return Expanded(
          child: RaisedButton(
            elevation: 6,
            child: (isDisable[superIndex][index] != null)
                ? child[superIndex][index]
                : null,
            shape:
                RoundedRectangleBorder(side: BorderSide(color: Colors.white)),
            color: Colors.teal[400],
            disabledColor: Colors.white,
            padding: EdgeInsets.all(0),
            splashColor: Colors.teal[500],
            onPressed: isButtonDisable(superIndex, index),
          ),
        );
      });
    }

    final List<Expanded> contentRows = new List.generate(
        columns,
        (index) => Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: gridGenerator(index),
              ),
            ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: contentRows,
    );
  }
}

gameMatrixList(column, row) {
  return (new List.generate(column, (i) => new List(row)));
}

mineGenerator(int maxMines, List<List> list) {
  Image mine = Image.asset("images/minas.png");
  int minesCounter = maxMines;
  while (minesCounter > 0) {
    int randomNumber = math.Random().nextInt(
        kGameDifficultyRows['easy'] * kGameDifficultyColumns['easy'] - 1);
    int rowCount = (randomNumber ~/ kGameDifficultyColumns['easy']);
    int columnCount = randomNumber % kGameDifficultyColumns['easy'];
    if (list[columnCount][rowCount] == null) {
      list[columnCount][rowCount] = mine;
      minesCounter = minesCounter - 1;
      print("$columnCount $rowCount");
    }
  }
  return list;
}
