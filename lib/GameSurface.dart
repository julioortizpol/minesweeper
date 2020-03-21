import 'package:flutter/material.dart';
import 'package:mineskeeper/GridBoard.dart';

class GameSurface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.teal[200],
          title: Text("MinesSweper"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              tooltip: "Settings",
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Row(
              children: <Widget>[],
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            child: GridBoard(),
          ),
        ));
  }
}
