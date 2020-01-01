import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gdg_app/providers/quoteProvider.dart';
import 'package:provider/provider.dart';
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
  }

  var someBool = true;
  final thingsToSay = [];
  var number;
  String thingToWriteidk(BuildContext context) {
    if (someBool) {
      thingsToSay.add(Provider.of<QuoteProvider>(context).mantra);
      final thefknTime = DateTime.now().hour;
      if (thefknTime >= 4 && thefknTime <= 12) {
        thingsToSay.add('Good morning');
      } else if (thefknTime >= 12 && thefknTime <= 17) {
        thingsToSay.add('Good afternoon');
      } else {
        thingsToSay.add('Good evening');
      }
      number = Random.secure().nextInt(thingsToSay.length);
      someBool = false;
    }
    return thingsToSay[number];
  }

  @override
  Widget build(BuildContext context) {
    getname();
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        thingToWriteidk(context) + ', $name.',
        style: TextStyle(
            fontFamily: 'Segoe',
            fontSize: 45,
            color: Colors.white,
            shadows: [Shadow(color: Colors.black, blurRadius: 12)]),
        textAlign: TextAlign.center,
      ),
    );
  }
}
