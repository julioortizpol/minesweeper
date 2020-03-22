import 'constants.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';

final columns = kGameDifficultyColumns['easy'];
final rows = kGameDifficultyRows['easy'];
Image mineWidget = Image.asset("images/mine.png");

class GridBoard extends StatefulWidget {
  @override
  _GridBoardState createState() => _GridBoardState();
}

class _GridBoardState extends State<GridBoard> {
  Map<String, bool> flags = {};
  generateGridNumber(int nearMines) {
    Text numbers = Text("$nearMines");
    return numbers;
  }

  List<List> child;
  List<List> isDisable;
  List<List> isNumber;

  gameInit() {
    child = gameMatrixList(columns, rows);
    isDisable = gameMatrixList(columns, rows);
    isNumber = gameMatrixList(columns, rows);
    child = mineGenerator(10, child);
  }

  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: new Text("Game over"),
        content: new Text("do you want to try again?"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("do you want to try again?"),
            onPressed: () {
              loseGame = false;
              resetGame();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  bool loseGame = false;

  gridAction(index, superIndex) {
    return (loseGame)
        ? () {
            _showDialog(context);
          }
        : () {
            setState(() {
              reveal(index, superIndex);
              isDisable[superIndex][index] = true;
              if (child[superIndex][index] == mineWidget) {
                loseGame = true;
                _showDialog(context);
              }
            });
          };
  }

  resetGame() {
    flags.clear();
    child.clear();
    isDisable.clear();
    isNumber.clear();
    setState(() {
      gameInit();
    });
  }

  sweepGrid(superIndex, index) {
    return (isDisable[superIndex][index] != null ||
            flags.containsKey('$superIndex,$index'))
        ? null
        : gridAction(index, superIndex);
  }

  //child[columnCount][rowCount];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gameInit();
  }

  void reveal(x, y) {
    if (outBounds(x, y)) return;
    if (isNumber[y][x] != null) return;
    if (child[y][x] == mineWidget) return;
    isNumber[y][x] = true;
    int minesNumber = calcNear(x, y, child);
    isDisable[y][x] = true;
    if (minesNumber != 0) {
      child[y][x] = generateGridNumber(minesNumber);
      return;
    }
    reveal(x - 1, y - 1);
    reveal(x - 1, y + 1);
    reveal(x + 1, y - 1);
    reveal(x + 1, y + 1);
    reveal(x - 1, y);
    reveal(x + 1, y);
    reveal(x, y - 1);
    reveal(x, y + 1);
  }

  void assignFlag(superIndex, index) {
    setState(() {
      if (flags.length < 10 && isDisable[superIndex][index] == null) {
        flags['$superIndex,$index'] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Expanded> gridGenerator(superIndex) {
      return List.generate(rows, (index) {
        return Expanded(
          child: GestureDetector(
            onLongPress: () {
              print("klk");
              assignFlag(superIndex, index);
            },
            onTap: (flags.containsKey('$superIndex,$index'))
                ? () {
                    setState(() {
                      flags.remove('$superIndex,$index');
                    });
                  }
                : null,
            child: RaisedButton(
              elevation: 6,
              child: (isDisable[superIndex][index] != null)
                  ? child[superIndex][index]
                  : (flags.containsKey('$superIndex,$index'))
                      ? Text("5")
                      : null,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white30)),
              color: Colors.teal[400],
              disabledColor: (flags.containsKey('$superIndex,$index'))
                  ? Colors.teal[400]
                  : Colors.white,
              padding: EdgeInsets.all(0),
              splashColor: Colors.teal[500],
              onPressed: sweepGrid(superIndex, index),
            ),
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
  int minesCounter = maxMines;
  while (minesCounter > 0) {
    int randomNumber = math.Random().nextInt(
        kGameDifficultyRows['easy'] * kGameDifficultyColumns['easy'] - 1);
    int rowCount = (randomNumber ~/ kGameDifficultyColumns['easy']);
    int columnCount = randomNumber % kGameDifficultyColumns['easy'];

    if (list[columnCount][rowCount] == null) {
      list[columnCount][rowCount] = mineWidget;
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
      i += (mine[offsetY + y][offsetX + x] == mineWidget) ? 1 : 0;
    }
  }
  return i;
}
