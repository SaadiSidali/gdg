import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdg_app/widgets/Quote.dart';
import 'package:gdg_app/widgets/greetings.dart';
import 'package:gdg_app/widgets/todayFocus.dart';
import 'package:intl/intl.dart';
import './widgets/weather.dart';

import './widgets/clock.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/images/image.jpg'),
                image: NetworkImage('https://i.redd.it/cx37grsl6i741.jpg'),
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
                Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Clock(),
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
