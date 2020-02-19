import 'package:flutter/material.dart';
import 'constants.dart';
import 'dart:math' as math;

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
  Image mine = Image.asset("images/minas.png");
  Text numbers = Text("1");

  List<List<Widget>> child = new List.generate(kGameDifficultyColumns['easy'],
      (i) => new List(kGameDifficultyRows['easy']));
  List<List<bool>> isDisable = new List.generate(kGameDifficultyColumns['easy'],
      (i) => new List(kGameDifficultyRows['easy']));

  isButtonDisable(superIndex, index) {
    return (isDisable[superIndex][index] != null)
        ? null
        : () {
            setState(() {
              isDisable[superIndex][index] = true;
            });
          };
  }

  mineGenerator(int maxMines) {
    int minesCounter = maxMines;
    print(maxMines);
    while (minesCounter > 0) {
      int randomNumber = math.Random().nextInt(
          kGameDifficultyRows['easy'] * kGameDifficultyColumns['easy'] - 1);
      int rowCount = (randomNumber ~/ kGameDifficultyColumns['easy']);
      int columnCount = randomNumber % kGameDifficultyColumns['easy'];
      if (child[columnCount][rowCount] == null) {
        child[columnCount][rowCount] = mine;
        minesCounter = minesCounter - 1;
        print("$columnCount $rowCount");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mineGenerator(7);
  }

  @override
  Widget build(BuildContext context) {
    List<Expanded> gridGenerator(superIndex) {
      return List.generate(kGameDifficultyRows['easy'], (index) {
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
        kGameDifficultyColumns['easy'],
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
