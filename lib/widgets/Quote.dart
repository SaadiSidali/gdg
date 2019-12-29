import 'package:flutter/material.dart';

class Quote extends StatefulWidget {
  @override
  _QuoteState createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  var quote =
      '“Almost any decision is better than no decision — just keep moving.” – Danielle LaPorte ';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SelectableText(
        '$quote',
        style: TextStyle(
            fontFamily: 'Segoe',
            fontSize: 20,
            color: Colors.white,
            shadows: [Shadow(color: Colors.black, blurRadius: 3)]),
        textAlign: TextAlign.center,
      ),
    );
  }
}
