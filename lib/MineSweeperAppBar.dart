import 'package:flutter/material.dart';

class MineSweeperAppBar extends StatefulWidget {
  @override
  _MineSweeperAppBarState createState() => _MineSweeperAppBarState();
}

class _MineSweeperAppBarState extends State<MineSweeperAppBar> {
  Widget createBottomElement(widget) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 8),
      child: Card(
        elevation: 7,
        color: Colors.teal[200],
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: widget,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            createBottomElement(Row(
              children: <Widget>[
                Icon(
                  Icons.timer,
                  size: 40,
                  color: Colors.teal[500],
                ),
                Text(
                  "   09:00 ",
                  style: TextStyle(color: Colors.teal[500], fontSize: 20),
                )
              ],
            )),
            createBottomElement(Icon(
              Icons.print,
              color: Colors.teal[500],
              size: 40,
            )),
            createBottomElement(Row(
              children: <Widget>[
                Icon(
                  Icons.timer,
                  size: 40,
                  color: Colors.teal[500],
                ),
                Text(
                  "   00:00",
                  style: TextStyle(color: Colors.teal[500], fontSize: 20),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
