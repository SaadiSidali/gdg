import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuoteProvider with ChangeNotifier {
  var _todayQuote =
      '“Almost any decision is better than no decision — just keep moving.” – Danielle LaPorte ';
  var _todayMantra = 'Be Fearless';

  String get quote {
    return _todayQuote;
  }

  String get mantra {
    return _todayMantra;
  }

  Future<void> getQuote() async {
    final url = 'https://gdg-app-22cea.firebaseio.com/quote.json';
    try {
      final response = await http.get(url);
      print(response.body);
      _todayQuote = response.body;
      notifyListeners();
      _todayQuote = json.decode(response.body);
    } catch (up) {
      print(up);
    }
  }

  Future<void> getMantra() async {
    final url = 'https://gdg-app-22cea.firebaseio.com/mantra.json';
    try {
      final response = await http.get(url);
      print(response.body);
      notifyListeners();
      _todayMantra = json.decode(response.body);
    } catch (up) {
      print(up);
    }
  }
}
