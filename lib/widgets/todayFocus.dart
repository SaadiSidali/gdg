import 'package:flutter/material.dart';

class TodayFocus extends StatefulWidget {
  @override
  TtodayFocusState createState() => TtodayFocusState();
}

class TtodayFocusState extends State<TodayFocus> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 200,
      child: TextField(
        scrollPadding: EdgeInsets.all(8),
        decoration: InputDecoration(
            hintStyle: TextStyle(
                fontFamily: 'Segoe',
                fontSize: 20,
                color: Colors.white60,
                shadows: [Shadow(color: Colors.black, blurRadius: 3)]),
            hintText: 'What\'s your main focus for today',
            focusColor: Colors.white),
        controller: _controller,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Segoe',
            fontSize: 20,
            color: Colors.white,
            shadows: [Shadow(color: Colors.black, blurRadius: 3)]),
      ),
    );
  }
}
