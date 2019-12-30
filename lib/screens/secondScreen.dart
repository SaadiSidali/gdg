import 'package:flutter/material.dart';
import 'package:gdg_app/screens/theTasksScreen.dart';
import 'package:gdg_app/widgets/Quote.dart';
import 'package:gdg_app/widgets/clock.dart';
import 'package:gdg_app/widgets/greetings.dart';
import 'package:gdg_app/widgets/todayFocus.dart';
import 'package:gdg_app/widgets/weather.dart';

import 'package:http/http.dart' as http;

class SecondScreen extends StatelessWidget {
  Future<String> imageLink() async {
    final url = 'https://gdg-app-22cea.firebaseio.com/wallpaper.json';
    try {
      final response = await http.get(url);
      print(response.body);
      return response.body;
    } catch (up) {
      print(up);
    }
  }

  @override
  Widget build(BuildContext context) {
    imageLink();
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/images/image.jpg'),
                image: NetworkImage('https://i.redd.it/gz4fut6njn741.jpg'),
              ),
              height: double.infinity,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Weather(),
                  ],
                ),
                GestureDetector(
                  onVerticalDragDown: (f) {
                    Navigator.of(context).pushNamed(
                      TasksScreen.routeName,
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FittedBox(child: Clock()),
                      Greetings(),
                      TodayFocus(),
                    ],
                  ),
                ),
                Quote()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
