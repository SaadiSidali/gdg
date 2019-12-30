import 'package:flutter/material.dart';

class TodayFocus extends StatefulWidget {
  @override
  TtodayFocusState createState() => TtodayFocusState();
}

class TtodayFocusState extends State<TodayFocus> {

  var _stringValue = '';

  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      child: TextField(
        onSubmitted: (value) {
          _stringValue = value;
          _controller.text = '';
          FocusScope.of(context).requestFocus(FocusNode());
        },
        scrollPadding: EdgeInsets.all(8),
        decoration: InputDecoration(
          
            hintStyle: TextStyle(
                fontFamily: 'Segoe',
                fontSize: 20,
                color: Colors.white70,
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
