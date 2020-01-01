import 'package:flutter/material.dart';
import 'package:gdg_app/providers/quoteProvider.dart';
import 'package:provider/provider.dart';

class Quote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<QuoteProvider>(context).getQuote();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: SelectableText(
          '${Provider.of<QuoteProvider>(context).quote}',
          style: TextStyle(
              fontFamily: 'Segoe',
              fontSize: 20,
              color: Colors.white,
              shadows: [Shadow(color: Colors.black, blurRadius: 3)]),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
