import 'package:flutter/material.dart';

class MineSweeperAppBar extends StatefulWidget {
  @override
  _MineSweeperAppBarState createState() => _MineSweeperAppBarState();
}

class _MineSweeperAppBarState extends State<MineSweeperAppBar> {
  Widget createBottomElement(widget, {double paddingRight = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: 10, bottom: 8, right: paddingRight),
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

  Widget createReusableRowIconText(IconData icon, String text) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 40,
          color: Colors.teal[500],
        ),
        Text(
          text,
          style: TextStyle(color: Colors.teal[500], fontSize: 20),
        )
      ],
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
            createBottomElement(
              createReusableRowIconText(Icons.timer, "   09:00 "),
            ),
            createBottomElement(Icon(
              Icons.print,
              color: Colors.teal[500],
              size: 40,
            )),
            createBottomElement(
                createReusableRowIconText(Icons.timer, "   09:00 "),
                paddingRight: 10),
          ],
        ),
      ),
    );
  }
}
