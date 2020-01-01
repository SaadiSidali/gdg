import 'package:flutter/material.dart';
import 'package:gdg_app/providers/auth.dart';
import 'package:provider/provider.dart';
import '../helpers/task_helper.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OneSignal.shared.init('aedd6133-091a-46e7-8498-e80ad975837f'); // 👀
    TaskHelper.setPhone(Provider.of<Auth>(context).userId);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Made by Tobias... for Tobias'),
          Container(
            child: Image.asset(
              'assets/images/gdg.jpg',
              fit: BoxFit.contain,
            ),
            height: 200,
            width: 200,
          )
        ],
      )),
    );
  }
}
