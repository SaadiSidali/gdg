import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Greetings extends StatefulWidget {
  @override
  _GreetingsState createState() => _GreetingsState();
}

class _GreetingsState extends State<Greetings> {
  var name;
  getname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'Pal';
    });
    await prefs.setString('name', 'sidali');
  }

  @override
  Widget build(BuildContext context) {
    getname();
    return Text(
      'Good evening, $name',
      style: TextStyle(
          fontFamily: 'Segoe',
          fontSize: 60,
          color: Colors.white,
          shadows: [Shadow(color: Colors.black, blurRadius: 12)]),
      textAlign: TextAlign.center,
    );
  }
}
