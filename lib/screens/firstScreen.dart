import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

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
          ],
        ),
      ),
    );
  }
}
