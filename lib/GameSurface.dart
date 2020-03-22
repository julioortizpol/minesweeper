import 'package:flutter/material.dart';
import 'package:mineskeeper/GridBoard.dart';
import 'package:mineskeeper/MineSweeperAppBar.dart';

class GameSurface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: MineSweeperAppBar(),
        ),
        body: SafeArea(
          child: Container(
            child: GridBoard(),
          ),
        ));
  }
}
