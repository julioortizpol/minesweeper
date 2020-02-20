import 'constants.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';

final columns = kGameDifficultyColumns['easy'];
final rows = kGameDifficultyRows['easy'];

class GridBoard extends StatefulWidget {
  @override
  _GridBoardState createState() => _GridBoardState();
}

class _GridBoardState extends State<GridBoard> {
  generateGridNumber(int nearMines) {
    Text numbers = Text("$nearMines");
    return numbers;
  }

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
    child = mineGenerator(7, child);
  }

  void reveal(x, y) {
    if (outBounds(x, y)) return;
    if (isDisable[x][y]) return;
    isDisable[x][y] = true;
    if (calcNear(x, y, child) != 0) return;
    reveal(x - 1, y - 1);
    reveal(x - 1, y + 1);
    reveal(x + 1, y - 1);
    reveal(x + 1, y + 1);
    reveal(x - 1, y);
    reveal(x + 1, y);
    reveal(x, y - 1);
    reveal(x, y + 1);
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
                RoundedRectangleBorder(side: BorderSide(color: Colors.white30)),
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

bool outBounds(int x, int y) {
  return x < 0 || y < 0 || x >= rows || y >= columns;
}

int calcNear(int x, int y, List<List> mine) {
  if (outBounds(x, y)) return 0;
  int i = 0;
  for (int offsetX = -1; offsetX <= 1; offsetX++) {
    for (int offsetY = -1; offsetY <= 1; offsetY++) {
      if (outBounds(offsetX + x, offsetY + y)) continue;
      i += (mine[offsetX + x][offsetY + y] != null) ? 1 : 0;
    }
  }
  return i;
}
