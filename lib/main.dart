import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              child: Image.network(
                'https://i.redd.it/wd67c1smj7741.jpg',
                fit: BoxFit.cover,
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

                Expanded(flex: 7,
                  child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Good evening, Sidali',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            fontSize: 60,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 12)
                            ]),
                        textAlign: TextAlign.center,
                      ),
                      Clock(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Nigga'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
