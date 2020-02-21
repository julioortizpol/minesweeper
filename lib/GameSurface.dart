import 'package:flutter/material.dart';
import 'package:mineskeeper/GridBoard.dart';

class GameSurface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("MinesSweper"),
        ),
        body: SafeArea(
          child: GridBoard(),
        ));
  }
}
